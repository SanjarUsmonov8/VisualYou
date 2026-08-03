from django.contrib.auth import logout
from rest_framework import status, viewsets
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.views import APIView

from .models import AIConversation, AIMessage
from .serializers import (
    AIConversationSerializer,
    AIMessageSerializer,
    AIUserMessageSerializer,
    RegisterSerializer,
    SyncRequestSerializer,
    UserSerializer,
)
from .sync import synchronize


class HealthView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)

    def get(self, request):
        return Response({'status': 'ok'})


class RegisterView(APIView):
    authentication_classes = ()
    permission_classes = (AllowAny,)

    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.save()
        token = Token.objects.create(user=user)
        return Response(
            {'token': token.key, 'user': UserSerializer(user).data},
            status=status.HTTP_201_CREATED,
        )


class LoginView(ObtainAuthToken):
    permission_classes = (AllowAny,)

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data, context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
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
        conversation.save(update_fields=('updated_at',))
        return Response(
            AIMessageSerializer(message).data,
            status=status.HTTP_201_CREATED,
        )
