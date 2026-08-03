from django.db.models.signals import post_save
from django.dispatch import receiver

from .models import (
    BodyPartState,
    CustomGraphRule,
    GraphHistoryEntry,
    HabitDefinition,
    HabitLogEntry,
    ReductionPlan,
    SpecialHabitGraph,
    SyncChange,
)


SYNC_MODELS = (
    HabitDefinition,
    HabitLogEntry,
    BodyPartState,
    GraphHistoryEntry,
    CustomGraphRule,
    SpecialHabitGraph,
    ReductionPlan,
)


@receiver(post_save)
def record_sync_change(sender, instance, raw=False, **kwargs):
    if raw or sender not in SYNC_MODELS:
        return
    SyncChange.objects.create(
        user=instance.user,
        entity_type=sender._meta.model_name,
        entity_id=instance.sync_identity,
    )
