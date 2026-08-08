import re

from django.apps import apps
from django.conf import settings
from django.contrib.auth import get_user_model
from django.core import mail
from django.test import SimpleTestCase
from django.test.utils import override_settings
from rest_framework.test import APITestCase

from .serializers import SyncRequestSerializer


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
