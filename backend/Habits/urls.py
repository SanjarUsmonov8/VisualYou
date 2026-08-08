from django.urls import include, path
from rest_framework.routers import DefaultRouter

from .views import (
    AIConversationViewSet,
    EmailLoginView,
    EmailSignupCompleteView,
    EmailSignupStartView,
    EmailSignupVerifyView,
    HealthView,
    LogoutView,
    MeView,
    SyncView,
)

router = DefaultRouter()
router.register('ai/conversations', AIConversationViewSet, basename='ai-conversation')

urlpatterns = [
    path('health/', HealthView.as_view(), name='health'),
    path('auth/email/start/', EmailSignupStartView.as_view(), name='email-signup-start'),
    path('auth/email/verify/', EmailSignupVerifyView.as_view(), name='email-signup-verify'),
    path('auth/email/complete/', EmailSignupCompleteView.as_view(), name='email-signup-complete'),
    path('auth/email/login/', EmailLoginView.as_view(), name='email-login'),
    path('auth/logout/', LogoutView.as_view(), name='logout'),
    path('me/', MeView.as_view(), name='me'),
    path('sync/', SyncView.as_view(), name='sync'),
    path('', include(router.urls)),
]
