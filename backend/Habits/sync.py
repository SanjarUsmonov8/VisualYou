from collections import defaultdict

from django.db import transaction
from rest_framework.exceptions import ValidationError

from .models import (
    BodyPartState,
    CustomGraphRule,
    GraphHistoryEntry,
    HabitDefinition,
    HabitLogEntry,
    ReductionPlan,
    SpecialHabitGraph,
    SyncChange,
    SyncDevice,
)

PULL_PAGE_SIZE = 500

ENTITY_COLLECTIONS = {
    HabitDefinition._meta.model_name: 'habit_definitions',
    HabitLogEntry._meta.model_name: 'habit_log_entries',
    BodyPartState._meta.model_name: 'body_part_states',
    GraphHistoryEntry._meta.model_name: 'graph_history_entries',
    CustomGraphRule._meta.model_name: 'custom_graph_rules',
    SpecialHabitGraph._meta.model_name: 'special_habit_graphs',
    ReductionPlan._meta.model_name: 'reduction_plans',
}


def _upsert(model, *, user, lookup, values, client_updated_at):
    instance = model.objects.select_for_update().filter(user=user, **lookup).first()
    if instance is not None and instance.client_updated_at >= client_updated_at:
        return instance

    if instance is None:
        return model.objects.create(
            user=user,
            client_updated_at=client_updated_at,
            **lookup,
            **values,
        )

    instance.client_updated_at = client_updated_at
    for field, value in values.items():
        setattr(instance, field, value)
    instance.save()
    return instance


def _habit_for(user, local_id):
    try:
        return HabitDefinition.objects.get(user=user, local_id=local_id)
    except HabitDefinition.DoesNotExist as error:
        raise ValidationError(
            {'habit_id': f'Habit {local_id!r} must be synchronized first.'}
        ) from error


def _apply_push(user, data):
    for item in data['habit_definitions']:
        row = dict(item)
        local_id = row.pop('id')
        updated_at = row.pop('updated_at')
        _upsert(
            HabitDefinition,
            user=user,
            lookup={'local_id': local_id},
            values=row,
            client_updated_at=updated_at,
        )

    for item in data['habit_log_entries']:
        row = dict(item)
        local_id = row.pop('id')
        habit = _habit_for(user, row.pop('habit_id'))
        updated_at = row.pop('updated_at')
        _upsert(
            HabitLogEntry,
            user=user,
            lookup={'local_id': local_id},
            values={**row, 'habit': habit},
            client_updated_at=updated_at,
        )

    for item in data['body_part_states']:
        row = dict(item)
        part_key = row.pop('part_key')
        updated_at = row.pop('updated_at')
        _upsert(
            BodyPartState,
            user=user,
            lookup={'part_key': part_key},
            values=row,
            client_updated_at=updated_at,
        )

    for item in data['graph_history_entries']:
        row = dict(item)
        local_id = row.pop('id')
        habit_id = row.pop('habit_id', None)
        habit = _habit_for(user, habit_id) if habit_id else None
        updated_at = row.pop('updated_at')
        _upsert(
            GraphHistoryEntry,
            user=user,
            lookup={'local_id': local_id},
            values={**row, 'habit': habit},
            client_updated_at=updated_at,
        )

    for item in data['custom_graph_rules']:
        row = dict(item)
        slot = row.pop('slot')
        habit = _habit_for(user, row.pop('habit_id'))
        updated_at = row.pop('updated_at')
        _upsert(
            CustomGraphRule,
            user=user,
            lookup={'slot': slot},
            values={**row, 'habit': habit},
            client_updated_at=updated_at,
        )

    for item in data['special_habit_graphs']:
        row = dict(item)
        slot = row.pop('slot')
        habit = _habit_for(user, row.pop('habit_id'))
        updated_at = row.pop('updated_at')
        _upsert(
            SpecialHabitGraph,
            user=user,
            lookup={'slot': slot},
            values={**row, 'habit': habit},
            client_updated_at=updated_at,
        )

    for item in data['reduction_plans']:
        row = dict(item)
        local_id = row.pop('id')
        habit = _habit_for(user, row.pop('habit_id'))
        updated_at = row.pop('updated_at')
        _upsert(
            ReductionPlan,
            user=user,
            lookup={'local_id': local_id},
            values={**row, 'habit': habit},
            client_updated_at=updated_at,
        )


def _base_record(instance):
    return {
        'remote_id': str(instance.pk),
        'updated_at': instance.client_updated_at,
        'server_updated_at': instance.server_updated_at,
        'deleted_at': instance.deleted_at,
    }


def _serialize(instance):
    data = _base_record(instance)
    if isinstance(instance, HabitDefinition):
        return {
            **data,
            'id': instance.local_id,
            'name_key': instance.name_key,
            'category': instance.category,
            'is_active': instance.is_active,
            'is_favorite': instance.is_favorite,
            'created_at': instance.created_at,
        }
    if isinstance(instance, HabitLogEntry):
        return {
            **data,
            'id': instance.local_id,
            'habit_id': instance.habit.local_id,
            'logged_at': instance.logged_at,
            'local_day': instance.local_day,
            'quantity': instance.quantity,
            'created_at': instance.created_at,
        }
    if isinstance(instance, BodyPartState):
        return {
            **data,
            'part_key': instance.part_key,
            'level': instance.level,
            'color_value': instance.color_value,
        }
    if isinstance(instance, GraphHistoryEntry):
        return {
            **data,
            'id': instance.local_id,
            'metric_key': instance.metric_key,
            'habit_id': instance.habit.local_id if instance.habit else None,
            'local_day': instance.local_day,
            'value': instance.value,
            'recorded_at': instance.recorded_at,
        }
    if isinstance(instance, CustomGraphRule):
        return {
            **data,
            'slot': instance.slot,
            'habit_id': instance.habit.local_id,
            'completed_points': instance.completed_points,
            'missed_points': instance.missed_points,
        }
    if isinstance(instance, SpecialHabitGraph):
        return {
            **data,
            'slot': instance.slot,
            'habit_id': instance.habit.local_id,
        }
    if isinstance(instance, ReductionPlan):
        return {
            **data,
            'id': instance.local_id,
            'habit_id': instance.habit.local_id,
            'mode': instance.mode,
            'started_on': instance.started_on,
            'is_active': instance.is_active,
            'created_at': instance.created_at,
        }
    raise TypeError(f'Unsupported sync model: {type(instance)!r}')


def _load_changed_records(user, changes):
    identities = defaultdict(set)
    for change in changes:
        identities[change.entity_type].add(change.entity_id)

    result = {collection: [] for collection in ENTITY_COLLECTIONS.values()}
    model_lookups = (
        (HabitDefinition, 'local_id'),
        (HabitLogEntry, 'local_id'),
        (BodyPartState, 'part_key'),
        (GraphHistoryEntry, 'local_id'),
        (CustomGraphRule, 'slot'),
        (SpecialHabitGraph, 'slot'),
        (ReductionPlan, 'local_id'),
    )
    for model, identity_field in model_lookups:
        entity_type = model._meta.model_name
        entity_ids = identities[entity_type]
        if not entity_ids:
            continue
        queryset = model.objects.filter(
            user=user,
            **{f'{identity_field}__in': entity_ids},
        )
        if hasattr(model, 'habit'):
            queryset = queryset.select_related('habit')
        result[ENTITY_COLLECTIONS[entity_type]] = [
            _serialize(instance) for instance in queryset
        ]
    return result


@transaction.atomic
def synchronize(user, validated_data):
    cursor = validated_data['cursor']
    _apply_push(user, validated_data)

    change_page = list(
        SyncChange.objects.filter(user=user, id__gt=cursor).order_by('id')[: PULL_PAGE_SIZE + 1]
    )
    has_more = len(change_page) > PULL_PAGE_SIZE
    returned_changes = change_page[:PULL_PAGE_SIZE]
    next_cursor = returned_changes[-1].id if returned_changes else cursor

    SyncDevice.objects.update_or_create(
        user=user,
        device_id=validated_data['device_id'],
        defaults={'last_sync_version': next_cursor},
    )

    return {
        'cursor': next_cursor,
        'has_more': has_more,
        'changes': _load_changed_records(user, returned_changes),
    }
