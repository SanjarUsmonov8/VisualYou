from django.contrib.auth import get_user_model
from rest_framework import serializers

from .models import AIConversation, AIMessage, HabitDefinition

User = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'first_name', 'last_name', 'date_joined')
        read_only_fields = ('id', 'date_joined')

    def validate_email(self, value):
        normalized = value.strip().lower()
        duplicate = User.objects.filter(email__iexact=normalized).exclude(pk=self.instance.pk)
        if duplicate.exists():
            raise serializers.ValidationError('An account with this email already exists.')
        return normalized


class EmailSignupStartSerializer(serializers.Serializer):
    email = serializers.EmailField()

    def validate_email(self, value):
        normalized = value.strip().lower()
        if User.objects.filter(email__iexact=normalized).exists():
            raise serializers.ValidationError(
                'An account with this email already exists. Log in instead.'
            )
        return normalized


class EmailSignupVerifySerializer(serializers.Serializer):
    challenge_id = serializers.UUIDField()
    code = serializers.RegexField(r'^\d{6}$')


class EmailSignupCompleteSerializer(serializers.Serializer):
    challenge_id = serializers.UUIDField()
    setup_token = serializers.CharField(min_length=32, max_length=200)
    password = serializers.CharField(write_only=True, trim_whitespace=False)


class EmailLoginSerializer(serializers.Serializer):
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True, trim_whitespace=False)

    def validate_email(self, value):
        return value.strip().lower()


class AIMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = AIMessage
        fields = ('id', 'role', 'content', 'created_at')
        read_only_fields = fields


class AIUserMessageSerializer(serializers.Serializer):
    content = serializers.CharField(max_length=4000, trim_whitespace=True)


class AIConversationSerializer(serializers.ModelSerializer):
    message_count = serializers.IntegerField(source='messages.count', read_only=True)

    class Meta:
        model = AIConversation
        fields = (
            'id',
            'title',
            'is_archived',
            'message_count',
            'created_at',
            'updated_at',
        )
        read_only_fields = ('id', 'message_count', 'created_at', 'updated_at')


class HabitDefinitionSyncSerializer(serializers.Serializer):
    id = serializers.CharField(max_length=160)
    name_key = serializers.CharField(max_length=160)
    category = serializers.ChoiceField(choices=HabitDefinition.Category.values)
    is_active = serializers.BooleanField()
    is_favorite = serializers.BooleanField()
    created_at = serializers.DateTimeField()
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class HabitLogEntrySyncSerializer(serializers.Serializer):
    id = serializers.CharField(max_length=200)
    habit_id = serializers.CharField(max_length=160)
    logged_at = serializers.DateTimeField()
    local_day = serializers.DateField()
    quantity = serializers.IntegerField(min_value=0)
    created_at = serializers.DateTimeField()
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class BodyPartStateSyncSerializer(serializers.Serializer):
    part_key = serializers.CharField(max_length=80)
    level = serializers.IntegerField(min_value=0, max_value=5)
    color_value = serializers.IntegerField(required=False, allow_null=True, default=None)
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class GraphHistoryEntrySyncSerializer(serializers.Serializer):
    id = serializers.CharField(max_length=200)
    metric_key = serializers.CharField(max_length=100)
    habit_id = serializers.CharField(max_length=160, required=False, allow_null=True)
    local_day = serializers.DateField()
    value = serializers.FloatField()
    recorded_at = serializers.DateTimeField()
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class CustomGraphRuleSyncSerializer(serializers.Serializer):
    slot = serializers.IntegerField(min_value=0, max_value=2)
    habit_id = serializers.CharField(max_length=160)
    completed_points = serializers.IntegerField()
    missed_points = serializers.IntegerField()
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class SpecialHabitGraphSyncSerializer(serializers.Serializer):
    slot = serializers.IntegerField(min_value=0)
    habit_id = serializers.CharField(max_length=160)
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class ReductionPlanSyncSerializer(serializers.Serializer):
    id = serializers.CharField(max_length=200)
    habit_id = serializers.CharField(max_length=160)
    mode = serializers.ChoiceField(choices=('hard', 'medium', 'easy'))
    started_on = serializers.DateField()
    is_active = serializers.BooleanField()
    created_at = serializers.DateTimeField()
    updated_at = serializers.DateTimeField()
    deleted_at = serializers.DateTimeField(required=False, allow_null=True, default=None)


class SyncRequestSerializer(serializers.Serializer):
    MAX_BATCH_ITEMS = 500

    device_id = serializers.UUIDField()
    cursor = serializers.IntegerField(min_value=0, required=False, default=0)
    habit_definitions = HabitDefinitionSyncSerializer(
        many=True,
        required=False,
        default=list,
    )
    habit_log_entries = HabitLogEntrySyncSerializer(
        many=True,
        required=False,
        default=list,
    )
    body_part_states = BodyPartStateSyncSerializer(
        many=True,
        required=False,
        default=list,
    )
    graph_history_entries = GraphHistoryEntrySyncSerializer(
        many=True,
        required=False,
        default=list,
    )
    custom_graph_rules = CustomGraphRuleSyncSerializer(
        many=True,
        required=False,
        default=list,
    )
    special_habit_graphs = SpecialHabitGraphSyncSerializer(
        many=True,
        required=False,
        default=list,
    )
    reduction_plans = ReductionPlanSyncSerializer(
        many=True,
        required=False,
        default=list,
    )

    def validate(self, attrs):
        collection_names = (
            'habit_definitions',
            'habit_log_entries',
            'body_part_states',
            'graph_history_entries',
            'custom_graph_rules',
            'special_habit_graphs',
            'reduction_plans',
        )
        item_count = sum(len(attrs[name]) for name in collection_names)
        if item_count > self.MAX_BATCH_ITEMS:
            raise serializers.ValidationError(
                f'A sync request can contain at most {self.MAX_BATCH_ITEMS} records.'
            )
        return attrs
