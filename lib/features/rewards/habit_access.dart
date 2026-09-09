import 'package:visualyou/features/rewards/rewards_models.dart';

const plusHabitIds = <String>{'consuming_sugar', 'studying'};

const proHabitIds = <String>{
  'brushing_teeth',
  'skin_care',
  'good_sleep',
  'meditation',
  'reading',
  'consistent_routine',
  'practising_gratitude',
  'productive_work',
  'excessive_screen_time',
  'excessive_caffeine',
  'social_media_overuse',
  'nail_biting',
  'gaming_overuse',
};

bool isPremiumHabitId(String habitId) =>
    plusHabitIds.contains(habitId) || proHabitIds.contains(habitId);

MembershipPlan? minimumPlanForHabit(String habitId) {
  if (proHabitIds.contains(habitId)) return MembershipPlan.pro;
  if (plusHabitIds.contains(habitId) || habitId.startsWith('custom_')) {
    return MembershipPlan.plus;
  }
  return null;
}

bool planCanUseHabit(MembershipPlan plan, String habitId) {
  if (habitId.startsWith('custom_')) return plan != MembershipPlan.free;
  if (proHabitIds.contains(habitId)) {
    return plan == MembershipPlan.pro || plan == MembershipPlan.ultra;
  }
  if (plusHabitIds.contains(habitId)) return plan != MembershipPlan.free;
  return true;
}

/// `null` means that the plan has no numerical-habit limit.
int? numericalHabitLimitForPlan(MembershipPlan plan) => switch (plan) {
  MembershipPlan.free => 0,
  MembershipPlan.plus => 4,
  MembershipPlan.pro || MembershipPlan.ultra => null,
};
