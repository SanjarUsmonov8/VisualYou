from django.urls import include, path
from rest_framework.routers import DefaultRouter

from .views import (
    AIConversationViewSet,
    HealthView,
    LoginView,
    LogoutView,
    MeView,
    RegisterView,
    SyncView,
)

router = DefaultRouter()
router.register('ai/conversations', AIConversationViewSet, basename='ai-conversation')

urlpatterns = [
    path('health/', HealthView.as_view(), name='health'),
    path('auth/register/', RegisterView.as_view(), name='register'),
    path('auth/login/', LoginView.as_view(), name='login'),
    path('auth/logout/', LogoutView.as_view(), name='logout'),
    path('me/', MeView.as_view(), name='me'),
    path('sync/', SyncView.as_view(), name='sync'),
    path('', include(router.urls)),
]
