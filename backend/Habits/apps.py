from django.apps import AppConfig


class HabitsConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'Habits'

    def ready(self):
        from . import signals  # noqa: F401
