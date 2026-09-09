enum MembershipPlan { free, plus, pro, ultra }

enum GatedFeature {
  body,
  graphs,
  reductionCalendar,
  growthCalendar,
  extraPlusGrowthPlans,
  extraProGrowthPlans,
  extraPlusReductionPlans,
  extraProReductionPlans,
  extraSingleGraphs,
  extraProSingleGraphs,
  extraNumericalHeatmaps,
  extraProNumericalHeatmaps,
}

enum BadgeKind { profile, body, calendar }

class RewardsSnapshot {
  const RewardsSnapshot({
    required this.plan,
    required this.planExpiresAt,
    required this.joinedAt,
    required this.tokenBalance,
    required this.streakAidBalance,
    required this.currentStreak,
    required this.profileProgress,
    required this.bodyProgress,
    required this.calendarProgress,
    required this.activityDays,
    required this.protectedStreakDays,
    required this.unlocks,
  });

  final MembershipPlan plan;
  final DateTime? planExpiresAt;
  final DateTime joinedAt;
  final int tokenBalance;
  final int streakAidBalance;
  final int currentStreak;
  final int profileProgress;
  final int bodyProgress;
  final int calendarProgress;
  final Set<DateTime> activityDays;
  final Set<DateTime> protectedStreakDays;
  final Map<GatedFeature, DateTime> unlocks;

  bool get isPaid => plan != MembershipPlan.free;

  // Existing feature gates use `isPlus` to mean Plus-level access. Pro and
  // Ultra inherit that access, so keep this compatibility getter inclusive.
  bool get isPlus => isPaid;
  bool get isPro => plan == MembershipPlan.pro;
  bool get isUltra => plan == MembershipPlan.ultra;

  Duration? remainingPlanTime(DateTime now) {
    final expiresAt = planExpiresAt;
    if (!isPaid || expiresAt == null) return null;
    final remaining = expiresAt.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  int get earnedBadgeCount =>
      (profileProgress >= 800 ? 1 : 0) +
      (bodyProgress >= 500 ? 1 : 0) +
      (calendarProgress >= 500 ? 1 : 0);

  bool isFeatureUnlocked(GatedFeature feature, DateTime now) {
    if (isPaid && (planExpiresAt == null || planExpiresAt!.isAfter(now))) {
      return true;
    }
    return unlocks[feature]?.isAfter(now) == true;
  }
}
