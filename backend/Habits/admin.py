from django.contrib import admin
from django.contrib.auth.admin import UserAdmin

from .models import (
    AIConversation,
    AIMessage,
    BodyPartState,
    CustomGraphRule,
    GraphHistoryEntry,
    HabitDefinition,
    HabitLogEntry,
    ReductionPlan,
    SpecialHabitGraph,
    SyncDevice,
    User,
)


admin.site.register(User, UserAdmin)
admin.site.register(HabitDefinition)
admin.site.register(HabitLogEntry)
admin.site.register(BodyPartState)
admin.site.register(GraphHistoryEntry)
admin.site.register(CustomGraphRule)
admin.site.register(SpecialHabitGraph)
admin.site.register(ReductionPlan)
admin.site.register(SyncDevice)
admin.site.register(AIConversation)
admin.site.register(AIMessage)
