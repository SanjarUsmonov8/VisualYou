import logging
import secrets
from datetime import timedelta

from django.conf import settings
from django.contrib.auth import get_user_model, logout
from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth.password_validation import validate_password
from django.core.exceptions import ValidationError as DjangoValidationError
from django.core.mail import send_mail
from django.db import transaction
from django.utils import timezone
from rest_framework import status, viewsets
from rest_framework.authtoken.models import Token
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.throttling import ScopedRateThrottle
from rest_framework.views import APIView

from .models import AIConversation, AIMessage, EmailSignupChallenge
from .ai_provider import AIProviderError, generate_reply
from .serializers import (
    AIConversationSerializer,
    AIMessageSerializer,
    AIUserMessageSerializer,
    EmailLoginSerializer,
    EmailSignupCompleteSerializer,
    EmailSignupStartSerializer,
    EmailSignupVerifySerializer,
    SyncRequestSerializer,
    UserSerializer,
)
from .sync import synchronize

User = get_user_model()
logger = logging.getLogger(__name__)


class HealthView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)

    def get(self, request):
        return Response({'status': 'ok'})


class EmailSignupStartView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    throttle_classes = (ScopedRateThrottle,)
    throttle_scope = 'email_signup_start'

    def post(self, request):
        serializer = EmailSignupStartSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        email = serializer.validated_data['email']
        code = f'{secrets.randbelow(1_000_000):06d}'
        expires_at = timezone.now() + timedelta(
            minutes=settings.EMAIL_SIGNUP_CODE_TTL_MINUTES
        )
        EmailSignupChallenge.objects.filter(
            email__iexact=email,
            consumed_at__isnull=True,
        ).delete()
        challenge = EmailSignupChallenge.objects.create(
            email=email,
            code_hash=make_password(code),
            expires_at=expires_at,
        )
        try:
            send_mail(
                'Your Visual You verification code',
                (
                    f'Your Visual You verification code is {code}.\n\n'
                    f'It expires in {settings.EMAIL_SIGNUP_CODE_TTL_MINUTES} minutes. '
                    'If you did not request this, you can ignore this email.'
                ),
                settings.DEFAULT_FROM_EMAIL,
                [email],
                fail_silently=False,
            )
        except Exception:
            logger.exception('Could not send signup verification email')
            challenge.delete()
            return Response(
                {'detail': 'We could not send the verification email. Try again later.'},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )
        return Response(
            {
                'challenge_id': str(challenge.id),
                'expires_in_seconds': settings.EMAIL_SIGNUP_CODE_TTL_MINUTES * 60,
            },
            status=status.HTTP_202_ACCEPTED,
        )


class EmailSignupVerifyView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    throttle_classes = (ScopedRateThrottle,)
    throttle_scope = 'email_signup_verify'

    def post(self, request):
        serializer = EmailSignupVerifySerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        try:
            challenge = EmailSignupChallenge.objects.get(
                pk=serializer.validated_data['challenge_id'],
                consumed_at__isnull=True,
            )
        except EmailSignupChallenge.DoesNotExist:
            return Response(
                {'detail': 'This verification request is no longer valid.'},
                status=status.HTTP_400_BAD_REQUEST,
            )
        if challenge.is_expired:
            return Response(
                {'detail': 'The verification code has expired. Request a new one.'},
                status=status.HTTP_400_BAD_REQUEST,
            )
        if challenge.failed_attempts >= 5:
            return Response(
                {'detail': 'Too many incorrect attempts. Request a new code.'},
                status=status.HTTP_400_BAD_REQUEST,
            )
        if not check_password(serializer.validated_data['code'], challenge.code_hash):
            challenge.failed_attempts += 1
            challenge.save(update_fields=('failed_attempts',))
            return Response(
                {'detail': 'The verification code is incorrect.'},
                status=status.HTTP_400_BAD_REQUEST,
            )
        setup_token = secrets.token_urlsafe(32)
        challenge.setup_token_hash = make_password(setup_token)
        challenge.verified_at = timezone.now()
        challenge.save(update_fields=('setup_token_hash', 'verified_at'))
        return Response({'setup_token': setup_token})


class EmailSignupCompleteView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    throttle_classes = (ScopedRateThrottle,)
    throttle_scope = 'email_signup_complete'

    def post(self, request):
        serializer = EmailSignupCompleteSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        with transaction.atomic():
            try:
                challenge = EmailSignupChallenge.objects.select_for_update().get(
                    pk=serializer.validated_data['challenge_id'],
                    consumed_at__isnull=True,
                    verified_at__isnull=False,
                )
            except EmailSignupChallenge.DoesNotExist:
                return Response(
                    {'detail': 'Email verification is required.'},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            if challenge.is_expired or not check_password(
                serializer.validated_data['setup_token'],
                challenge.setup_token_hash,
            ):
                return Response(
                    {'detail': 'The password setup session has expired. Start again.'},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            if User.objects.filter(email__iexact=challenge.email).exists():
                return Response(
                    {'detail': 'An account with this email already exists.'},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            provisional_user = User(email=challenge.email)
            try:
                validate_password(
                    serializer.validated_data['password'],
                    user=provisional_user,
                )
            except DjangoValidationError as error:
                return Response(
                    {'password': list(error.messages)},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            user = User.objects.create_user(
                username=f'user_{secrets.token_hex(16)}',
                email=challenge.email,
                password=serializer.validated_data['password'],
            )
            challenge.consumed_at = timezone.now()
            challenge.save(update_fields=('consumed_at',))
            token = Token.objects.create(user=user)
        return Response(
            {'token': token.key, 'user': UserSerializer(user).data},
            status=status.HTTP_201_CREATED,
        )


class EmailLoginView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)
    throttle_classes = (ScopedRateThrottle,)
    throttle_scope = 'email_login'

    def post(self, request):
        serializer = EmailLoginSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = User.objects.filter(
            email__iexact=serializer.validated_data['email'],
            is_active=True,
        ).first()
        if user is None or not user.check_password(serializer.validated_data['password']):
            return Response(
                {'detail': 'The email or password is incorrect.'},
                status=status.HTTP_400_BAD_REQUEST,
            )
        token, _ = Token.objects.get_or_create(user=user)
        return Response({'token': token.key, 'user': UserSerializer(user).data})


class LogoutView(APIView):
    def post(self, request):
        if request.auth:
            request.auth.delete()
        logout(request)
        return Response(status=status.HTTP_204_NO_CONTENT)


class MeView(APIView):
    def get(self, request):
        return Response(UserSerializer(request.user).data)

    def patch(self, request):
        serializer = UserSerializer(request.user, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)


class SyncView(APIView):
    def post(self, request):
        serializer = SyncRequestSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        return Response(synchronize(request.user, serializer.validated_data))


class AIConversationViewSet(viewsets.ModelViewSet):
    serializer_class = AIConversationSerializer

    def get_throttles(self):
        if self.action == 'messages' and self.request.method == 'POST':
            self.throttle_scope = 'ai_message'
            return [ScopedRateThrottle()]
        return super().get_throttles()

    def get_queryset(self):
        return AIConversation.objects.filter(user=self.request.user).prefetch_related('messages')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=True, methods=('get', 'post'))
    def messages(self, request, pk=None):
        conversation = self.get_object()
        if request.method == 'GET':
            return Response(AIMessageSerializer(conversation.messages.all(), many=True).data)

        serializer = AIUserMessageSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        message = AIMessage.objects.create(
            conversation=conversation,
            role=AIMessage.Role.USER,
            content=serializer.validated_data['content'],
        )
        if not conversation.title:
            title = serializer.validated_data['content'].strip()
            conversation.title = (title or 'Image conversation')[:160]
        conversation.save(update_fields=('title', 'updated_at'))
        try:
            reply = generate_reply(
                conversation.messages.all(),
                image_base64=serializer.validated_data['image_base64'],
                image_mime_type=serializer.validated_data['image_mime_type'],
            )
        except AIProviderError as exc:
            logger.warning('AI provider request failed: %s', exc)
            return Response(
                {
                    'detail': str(exc),
                    'user_message': AIMessageSerializer(message).data,
                },
                status=status.HTTP_502_BAD_GATEWAY,
            )
        assistant_message = AIMessage.objects.create(
            conversation=conversation,
            role=AIMessage.Role.ASSISTANT,
            content=reply,
        )
        conversation.save(update_fields=('updated_at',))
        return Response(
            {
                'user_message': AIMessageSerializer(message).data,
                'assistant_message': AIMessageSerializer(assistant_message).data,
            },
            status=status.HTTP_201_CREATED,
        )
