import json
import re
from types import SimpleNamespace
from unittest.mock import patch

from django.apps import apps
from django.conf import settings
from django.contrib.auth import get_user_model
from django.core import mail
from django.test import SimpleTestCase
from django.test.utils import override_settings
from rest_framework.test import APITestCase

from .ai_provider import generate_reply
from .models import AIMessage
from .serializers import AIUserMessageSerializer, SyncRequestSerializer


class BackendConfigurationTests(SimpleTestCase):
    def test_custom_user_model_is_configured(self):
        user_model = apps.get_model(settings.AUTH_USER_MODEL)

        self.assertEqual(settings.AUTH_USER_MODEL, 'Habits.User')
        self.assertEqual(user_model.__name__, 'User')

    def test_postgresql_is_the_only_configured_database(self):
        self.assertEqual(
            settings.DATABASES['default']['ENGINE'],
            'django.db.backends.postgresql',
        )


class SyncRequestSerializerTests(SimpleTestCase):
    def test_empty_pull_request_is_valid(self):
        serializer = SyncRequestSerializer(
            data={
                'device_id': '8dbb5a78-94fb-4ccd-9ea9-ef25809bcd2f',
                'cursor': 0,
            }
        )

        self.assertTrue(serializer.is_valid(), serializer.errors)
        self.assertEqual(serializer.validated_data['habit_definitions'], [])

    def test_sync_batch_is_limited(self):
        habit = {
            'id': 'water',
            'name_key': 'Drinking water',
            'category': 'good',
            'is_active': True,
            'is_favorite': True,
            'created_at': '2026-08-03T10:00:00Z',
            'updated_at': '2026-08-03T10:00:00Z',
            'deleted_at': None,
        }
        serializer = SyncRequestSerializer(
            data={
                'device_id': '8dbb5a78-94fb-4ccd-9ea9-ef25809bcd2f',
                'habit_definitions': [habit] * 501,
            }
        )

        self.assertFalse(serializer.is_valid())
        self.assertIn('non_field_errors', serializer.errors)


class AIMessageSerializerTests(SimpleTestCase):
    def test_rejects_invalid_image_data(self):
        serializer = AIUserMessageSerializer(
            data={
                'content': 'What is shown here?',
                'image_base64': 'not-base64',
                'image_mime_type': 'image/jpeg',
            }
        )

        self.assertFalse(serializer.is_valid())
        self.assertIn('non_field_errors', serializer.errors)


@override_settings(
    GEMINI_API_KEY='test-key',
    GEMINI_MODEL='gemini-test',
    GEMINI_TIMEOUT_SECONDS=5,
    GEMINI_MAX_OUTPUT_TOKENS=200,
    GEMINI_HISTORY_MESSAGE_LIMIT=20,
)
class GeminiProviderTests(SimpleTestCase):
    @patch('Habits.ai_provider.request.urlopen')
    def test_uses_native_gemini_endpoint_and_api_key_header(self, mocked_urlopen):
        response = mocked_urlopen.return_value.__enter__.return_value
        response.read.return_value = json.dumps(
            {
                'candidates': [
                    {'content': {'parts': [{'text': 'A helpful response.'}]}}
                ]
            }
        ).encode()
        messages = [SimpleNamespace(role='user', content='Help me build a habit.')]

        result = generate_reply(messages)

        self.assertEqual(result, 'A helpful response.')
        sent_request = mocked_urlopen.call_args.args[0]
        self.assertIn('gemini-test:generateContent', sent_request.full_url)
        self.assertEqual(sent_request.get_header('X-goog-api-key'), 'test-key')


class AIConversationApiTests(APITestCase):
    def setUp(self):
        self.user = get_user_model().objects.create_user(
            username='ai-user',
            email='ai@example.com',
            password='A-long-test-password-2048!',
        )
        self.client.force_authenticate(self.user)

    @patch('Habits.views.generate_reply', return_value='Start with one small step.')
    def test_message_endpoint_stores_user_and_assistant_messages(self, generate):
        conversation = self.client.post(
            '/api/v1/ai/conversations/',
            {'title': ''},
            format='json',
        )
        self.assertEqual(conversation.status_code, 201)

        response = self.client.post(
            f"/api/v1/ai/conversations/{conversation.data['id']}/messages/",
            {'content': 'How can I start?'},
            format='json',
        )

        self.assertEqual(response.status_code, 201)
        self.assertEqual(
            response.data['assistant_message']['content'],
            'Start with one small step.',
        )
        self.assertEqual(AIMessage.objects.filter(conversation_id=conversation.data['id']).count(), 2)
        generate.assert_called_once()


@override_settings(EMAIL_BACKEND='django.core.mail.backends.locmem.EmailBackend')
class EmailSignupTests(APITestCase):
    def test_email_is_verified_before_password_and_login_uses_email(self):
        start = self.client.post(
            '/api/v1/auth/email/start/',
            {'email': 'Person@Example.com'},
            format='json',
        )
        self.assertEqual(start.status_code, 202)
        self.assertEqual(len(mail.outbox), 1)
        code = re.search(r'\b(\d{6})\b', mail.outbox[0].body).group(1)

        verify = self.client.post(
            '/api/v1/auth/email/verify/',
            {'challenge_id': start.data['challenge_id'], 'code': code},
            format='json',
        )
        self.assertEqual(verify.status_code, 200)

        complete = self.client.post(
            '/api/v1/auth/email/complete/',
            {
                'challenge_id': start.data['challenge_id'],
                'setup_token': verify.data['setup_token'],
                'password': 'A-long-test-password-2048!',
            },
            format='json',
        )
        self.assertEqual(complete.status_code, 201)
        self.assertIn('token', complete.data)
        self.assertTrue(
            get_user_model().objects.filter(email='person@example.com').exists()
        )

        login = self.client.post(
            '/api/v1/auth/email/login/',
            {
                'email': 'person@example.com',
                'password': 'A-long-test-password-2048!',
            },
            format='json',
        )
        self.assertEqual(login.status_code, 200)
        self.assertIn('token', login.data)
