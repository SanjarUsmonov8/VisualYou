from django.apps import apps
from django.conf import settings
from django.test import SimpleTestCase

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
