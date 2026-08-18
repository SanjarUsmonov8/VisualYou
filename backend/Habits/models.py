import uuid

from django.conf import settings
from django.contrib.auth.models import AbstractUser
from django.db import models


class User(AbstractUser):
    """Visual You account model, defined before the initial migration."""

    email = models.EmailField(unique=True)


class EmailSignupChallenge(models.Model):
    """Short-lived proof that a person controls an email address."""

    class Purpose(models.TextChoices):
        SIGNUP = 'signup', 'Sign up'
        PASSWORD_RESET = 'password_reset', 'Password reset'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    email = models.EmailField(db_index=True)
    purpose = models.CharField(
        max_length=24,
        choices=Purpose.choices,
        default=Purpose.SIGNUP,
        db_index=True,
    )
    code_hash = models.CharField(max_length=128)
    setup_token_hash = models.CharField(max_length=128, blank=True)
    expires_at = models.DateTimeField(db_index=True)
    verified_at = models.DateTimeField(null=True, blank=True)
    consumed_at = models.DateTimeField(null=True, blank=True)
    failed_attempts = models.PositiveSmallIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    @property
    def is_expired(self):
        from django.utils import timezone

        return timezone.now() >= self.expires_at


class SyncRecord(models.Model):
    """Shared conflict and deletion fields for data originating on a device."""

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='+',
    )
    client_updated_at = models.DateTimeField()
    server_updated_at = models.DateTimeField(auto_now=True, db_index=True)
    deleted_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        abstract = True

    @property
    def sync_identity(self):
        raise NotImplementedError


class HabitDefinition(SyncRecord):
    class Category(models.TextChoices):
        GOOD = 'good', 'Good'
        EXERCISE = 'exercise', 'Exercise'
        REDUCTION = 'reduction', 'Reduction'
        CUSTOM = 'custom', 'Custom'

    local_id = models.CharField(max_length=160)
    name_key = models.CharField(max_length=160)
    category = models.CharField(max_length=32, choices=Category.choices)
    is_active = models.BooleanField(default=True)
    is_favorite = models.BooleanField(default=False)
    created_at = models.DateTimeField()

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'local_id'),
                name='unique_user_habit_local_id',
            ),
        ]

    @property
    def sync_identity(self):
        return self.local_id

    def __str__(self):
        return f'{self.user_id}:{self.local_id}'


class HabitLogEntry(SyncRecord):
    local_id = models.CharField(max_length=200)
    habit = models.ForeignKey(
        HabitDefinition,
        on_delete=models.PROTECT,
        related_name='logs',
    )
    logged_at = models.DateTimeField()
    local_day = models.DateField()
    quantity = models.PositiveIntegerField(default=1)
    created_at = models.DateTimeField()

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'local_id'),
                name='unique_user_habit_log_local_id',
            ),
        ]

    @property
    def sync_identity(self):
        return self.local_id


class BodyPartState(SyncRecord):
    part_key = models.CharField(max_length=80)
    level = models.PositiveSmallIntegerField(default=3)
    color_value = models.BigIntegerField(null=True, blank=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'part_key'),
                name='unique_user_body_part',
            ),
            models.CheckConstraint(
                condition=models.Q(level__gte=0) & models.Q(level__lte=5),
                name='body_part_level_between_0_and_5',
            ),
        ]

    @property
    def sync_identity(self):
        return self.part_key


class GraphHistoryEntry(SyncRecord):
    local_id = models.CharField(max_length=200)
    metric_key = models.CharField(max_length=100)
    habit = models.ForeignKey(
        HabitDefinition,
        on_delete=models.PROTECT,
        related_name='graph_history',
        null=True,
        blank=True,
    )
    local_day = models.DateField()
    value = models.FloatField()
    recorded_at = models.DateTimeField()

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'local_id'),
                name='unique_user_graph_history_local_id',
            ),
        ]

    @property
    def sync_identity(self):
        return self.local_id


class CustomGraphRule(SyncRecord):
    slot = models.PositiveSmallIntegerField()
    habit = models.ForeignKey(
        HabitDefinition,
        on_delete=models.PROTECT,
        related_name='custom_graph_rules',
    )
    completed_points = models.IntegerField()
    missed_points = models.IntegerField()

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'slot'),
                name='unique_user_custom_graph_slot',
            ),
        ]

    @property
    def sync_identity(self):
        return str(self.slot)


class SpecialHabitGraph(SyncRecord):
    slot = models.PositiveSmallIntegerField()
    habit = models.ForeignKey(
        HabitDefinition,
        on_delete=models.PROTECT,
        related_name='special_graphs',
    )

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'slot'),
                name='unique_user_special_graph_slot',
            ),
        ]

    @property
    def sync_identity(self):
        return str(self.slot)


class ReductionPlan(SyncRecord):
    class Mode(models.TextChoices):
        HARD = 'hard', 'Hard'
        MEDIUM = 'medium', 'Medium'
        EASY = 'easy', 'Easy'

    local_id = models.CharField(max_length=200)
    habit = models.ForeignKey(
        HabitDefinition,
        on_delete=models.PROTECT,
        related_name='reduction_plans',
    )
    mode = models.CharField(max_length=16, choices=Mode.choices)
    started_on = models.DateField()
    is_active = models.BooleanField(default=True)
    created_at = models.DateTimeField()

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'local_id'),
                name='unique_user_reduction_plan_local_id',
            ),
        ]

    @property
    def sync_identity(self):
        return self.local_id


class SyncChange(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='sync_changes',
    )
    entity_type = models.CharField(max_length=40)
    entity_id = models.CharField(max_length=200)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        indexes = [models.Index(fields=('user', 'id'))]


class SyncDevice(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='sync_devices',
    )
    device_id = models.UUIDField()
    last_sync_version = models.PositiveBigIntegerField(default=0)
    last_seen_at = models.DateTimeField(auto_now=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=('user', 'device_id'),
                name='unique_user_sync_device',
            ),
        ]


class AIConversation(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name='ai_conversations',
    )
    title = models.CharField(max_length=160, blank=True)
    is_archived = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-updated_at',)


class AIMessage(models.Model):
    class Role(models.TextChoices):
        USER = 'user', 'User'
        ASSISTANT = 'assistant', 'Assistant'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    conversation = models.ForeignKey(
        AIConversation,
        on_delete=models.CASCADE,
        related_name='messages',
    )
    role = models.CharField(max_length=16, choices=Role.choices)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ('created_at',)
