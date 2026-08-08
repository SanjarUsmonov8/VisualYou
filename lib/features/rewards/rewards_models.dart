enum MembershipPlan { free, plus }

enum GatedFeature { body, graphs, reductionCalendar, extraSingleGraphs }

enum BadgeKind { profile, body, calendar }

class RewardsSnapshot {
  const RewardsSnapshot({
    required this.plan,
    required this.planExpiresAt,
    required this.joinedAt,
    required this.tokenBalance,
    required this.currentStreak,
    required this.profileProgress,
    required this.bodyProgress,
    required this.calendarProgress,
    required this.activityDays,
    required this.unlocks,
  });

  final MembershipPlan plan;
  final DateTime? planExpiresAt;
  final DateTime joinedAt;
  final int tokenBalance;
  final int currentStreak;
  final int profileProgress;
  final int bodyProgress;
  final int calendarProgress;
  final Set<DateTime> activityDays;
  final Map<GatedFeature, DateTime> unlocks;

  bool get isPlus => plan == MembershipPlan.plus;

  Duration? remainingPlanTime(DateTime now) {
    final expiresAt = planExpiresAt;
    if (!isPlus || expiresAt == null) return null;
    final remaining = expiresAt.difference(now);
    return remaining.isNegative ? Duration.zero : remaining;
  }

  int get earnedBadgeCount =>
      (profileProgress >= 800 ? 1 : 0) +
      (bodyProgress >= 500 ? 1 : 0) +
      (calendarProgress >= 500 ? 1 : 0);

  bool isFeatureUnlocked(GatedFeature feature, DateTime now) {
    if (isPlus && (planExpiresAt == null || planExpiresAt!.isAfter(now))) {
      return true;
    }
    return unlocks[feature]?.isAfter(now) == true;
  }
}
