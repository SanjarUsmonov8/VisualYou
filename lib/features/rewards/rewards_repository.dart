import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_models.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';

class RewardsRepository {
  RewardsRepository(this.database);

  final AppDatabase database;

  Future<void> initialize({DateTime? now}) async {
    final current = now ?? DateTime.now();
    final today = _day(current);
    final weekEnd = _nextMonday(today);
    await database.transaction(() async {
      await database
          .into(database.rewardStates)
          .insert(
            RewardStatesCompanion.insert(
              createdAt: current,
              updatedAt: current,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      await database
          .into(database.rewardEvents)
          .insert(
            RewardEventsCompanion.insert(
              id: 'welcome:profile-bronze',
              badgeKey: const Value('profile'),
              amount: 140,
              occurredOn: today,
              createdAt: current,
            ),
            mode: InsertMode.insertOrIgnore,
          );
      for (final feature in GatedFeature.values) {
        if (feature == GatedFeature.extraSingleGraphs) continue;
        await database
            .into(database.featureUnlocks)
            .insert(
              FeatureUnlocksCompanion.insert(
                featureKey: feature.name,
                unlockedUntil: weekEnd,
                updatedAt: current,
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
      await _seedDefaultGraphs(current);
    });
    await refresh(now: current);
  }

  Future<RewardsSnapshot> loadSnapshot({DateTime? now}) async {
    final state = await _loadState();
    final unlockRows = await database.select(database.featureUnlocks).get();
    final activityDays = await _loadActivityDays();
    return RewardsSnapshot(
      plan: state.plan == 'plus' ? MembershipPlan.plus : MembershipPlan.free,
      planExpiresAt: state.planExpiresAt,
      joinedAt: state.createdAt,
      tokenBalance: state.tokenBalance,
      currentStreak: state.currentStreak,
      profileProgress: state.profileProgress,
      bodyProgress: state.bodyProgress,
      calendarProgress: state.calendarProgress,
      activityDays: activityDays,
      unlocks: {
        for (final row in unlockRows)
          if (GatedFeature.values.any(
            (feature) => feature.name == row.featureKey,
          ))
            GatedFeature.values.firstWhere(
              (feature) => feature.name == row.featureKey,
            ): row.unlockedUntil,
      },
    );
  }

  Future<void> refresh({DateTime? now}) async {
    final current = now ?? DateTime.now();
    final today = _day(current);
    var membership = await _loadState();
    if (membership.plan == 'plus' &&
        membership.planExpiresAt?.isBefore(current) == true) {
      await (database.update(
        database.rewardStates,
      )..where((row) => row.id.equals(1))).write(
        RewardStatesCompanion(
          plan: const Value('free'),
          planExpiresAt: const Value(null),
          updatedAt: Value(current),
        ),
      );
      membership = await _loadState();
    }
    if (membership.plan == 'plus') {
      await _applyEvent(
        id: 'plus-month:${current.year}-${current.month}',
        amount: 70,
        badge: BadgeKind.profile,
        occurredOn: today,
        now: current,
      );
    }
    final activityDays = await _loadActivityDays();
    final streak = _calculateStreak(activityDays, today);
    await (database.update(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).write(
      RewardStatesCompanion(
        currentStreak: Value(streak.length),
        updatedAt: Value(current),
      ),
    );
    for (final milestone in const {7: 35, 14: 80, 21: 100, 30: 150}.entries) {
      if (streak.length < milestone.key || streak.start == null) continue;
      await _applyEvent(
        id: 'streak:${_key(streak.start!)}:${milestone.key}',
        amount: milestone.value,
        badge: BadgeKind.profile,
        occurredOn: today,
        now: current,
      );
    }

    var state = await _loadState();
    final currentWeek = _monday(today);
    var week = state.lastEvaluatedWeek == null
        ? await _firstCompletedWeek(currentWeek)
        : state.lastEvaluatedWeek!.add(const Duration(days: 7));
    while (week != null && week.isBefore(currentWeek)) {
      await _evaluateWeek(week, current);
      await (database.update(
        database.rewardStates,
      )..where((row) => row.id.equals(1))).write(
        RewardStatesCompanion(
          lastEvaluatedWeek: Value(week),
          updatedAt: Value(current),
        ),
      );
      week = week.add(const Duration(days: 7));
      state = await _loadState();
    }
    await _awardCompletedBadges(today, current);
  }

  Future<void> setPlan(MembershipPlan plan, {DateTime? now}) async {
    final current = now ?? DateTime.now();
    await (database.update(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).write(
      RewardStatesCompanion(
        plan: Value(plan.name),
        planExpiresAt: Value(
          plan == MembershipPlan.plus ? _sameDayNextMonth(current) : null,
        ),
        updatedAt: Value(current),
      ),
    );
    if (plan == MembershipPlan.plus) {
      await _applyEvent(
        id: 'plus-month:${current.year}-${current.month}',
        amount: 70,
        badge: BadgeKind.profile,
        occurredOn: _day(current),
        now: current,
      );
    }
  }

  static DateTime _sameDayNextMonth(DateTime date) {
    final firstOfFollowingMonth = DateTime(date.year, date.month + 2);
    final lastDayOfNextMonth = firstOfFollowingMonth.subtract(
      const Duration(days: 1),
    );
    final day = math.min(date.day, lastDayOfNextMonth.day);
    return DateTime(
      lastDayOfNextMonth.year,
      lastDayOfNextMonth.month,
      day,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }

  Future<bool> spendTokens({
    required int amount,
    required String reason,
    bool chargePlus = false,
    DateTime? now,
  }) async {
    final current = now ?? DateTime.now();
    final state = await _loadState();
    if (state.plan == 'plus' && !chargePlus) return true;
    if (state.tokenBalance < amount) return false;
    return _applyEvent(
      id: 'spend:$reason:${current.microsecondsSinceEpoch}',
      amount: -amount,
      occurredOn: _day(current),
      now: current,
    );
  }

  Future<bool> unlockFeature(GatedFeature feature, {DateTime? now}) async {
    final current = now ?? DateTime.now();
    final state = await _loadState();
    if (state.plan == 'plus') return true;
    if (state.tokenBalance < 70) return false;
    final paid = await spendTokens(
      amount: 70,
      reason: 'unlock-${feature.name}',
      now: current,
    );
    if (!paid) return false;
    await unlockFeatureAfterPayment(feature, now: current);
    return true;
  }

  Future<void> unlockFeatureAfterPayment(
    GatedFeature feature, {
    DateTime? now,
  }) async {
    final current = now ?? DateTime.now();
    final until = _day(current).add(const Duration(days: 7));
    await database
        .into(database.featureUnlocks)
        .insertOnConflictUpdate(
          FeatureUnlocksCompanion.insert(
            featureKey: feature.name,
            unlockedUntil: until,
            updatedAt: current,
          ),
        );
  }

  Future<void> _seedDefaultGraphs(DateTime now) async {
    final customCount =
        (await database.select(database.customGraphRules).get()).length;
    if (customCount == 0) {
      const defaults = [
        ('healthy_eating', 3, -2),
        ('alcohol', -6, 5),
        ('smoking', -6, 5),
      ];
      for (var slot = 0; slot < defaults.length; slot++) {
        final value = defaults[slot];
        await database
            .into(database.customGraphRules)
            .insert(
              CustomGraphRulesCompanion.insert(
                slot: Value(slot),
                habitId: value.$1,
                completedPoints: value.$2,
                missedPoints: value.$3,
                updatedAt: now,
              ),
            );
      }
    }
    final specialCount =
        (await database.select(database.specialHabitGraphs).get()).length;
    if (specialCount == 0) {
      for (final value in const [(0, 'alcohol'), (1, 'water')]) {
        await database
            .into(database.specialHabitGraphs)
            .insert(
              SpecialHabitGraphsCompanion.insert(
                slot: Value(value.$1),
                habitId: value.$2,
                updatedAt: now,
              ),
            );
      }
    }
  }

  Future<void> _evaluateWeek(DateTime monday, DateTime now) async {
    final end = monday.add(const Duration(days: 7));
    final scores = await _calendarScores(monday, end);
    final excellent = scores
        .where((score) => score != null && score >= 2)
        .length;
    final good = scores.where((score) => score == 1).length;
    final terrible = scores
        .where((score) => score != null && score <= -2)
        .length;
    final bad = scores.where((score) => score == -1).length;
    if (excellent == 7) {
      await _badgeWeekEvent(
        monday,
        'calendar-blue',
        30,
        BadgeKind.calendar,
        now,
      );
    } else if (excellent + good == 7) {
      await _badgeWeekEvent(
        monday,
        'calendar-green',
        10,
        BadgeKind.calendar,
        now,
      );
    } else if (terrible >= 6) {
      await _badgeWeekEvent(
        monday,
        'calendar-red',
        -30,
        BadgeKind.calendar,
        now,
      );
    } else if (terrible + bad == 7 && bad >= 2) {
      await _badgeWeekEvent(
        monday,
        'calendar-orange',
        -15,
        BadgeKind.calendar,
        now,
      );
    }

    final reduction = await _reductionWeek(monday, end);
    if (reduction.trackedAllDays && reduction.violations == 0) {
      await _badgeWeekEvent(
        monday,
        'reduction-on-track',
        25,
        BadgeKind.calendar,
        now,
      );
    }
    for (var index = 0; index < reduction.violations; index++) {
      await _badgeWeekEvent(
        monday,
        'reduction-red-$index',
        -10,
        BadgeKind.calendar,
        now,
      );
    }

    final bodyMetrics = await _bodyMetrics(monday, end);
    if (bodyMetrics.healthyOrganDays >= 5) {
      await _badgeWeekEvent(monday, 'organs-high', 30, BadgeKind.body, now);
    }
    if (bodyMetrics.poorOrganDays >= 5) {
      await _badgeWeekEvent(monday, 'organs-low', -20, BadgeKind.body, now);
    }
    if (bodyMetrics.musclesAtLeastGreen) {
      await _badgeWeekEvent(monday, 'muscles-high', 20, BadgeKind.body, now);
    }
    final graphDays = await _customGraphDayTotals(monday, end);
    if (graphDays.where((value) => value > 0).length >= 5) {
      await _badgeWeekEvent(monday, 'graph-high', 30, BadgeKind.body, now);
    }
    if (graphDays.where((value) => value < 0).length >= 5) {
      await _badgeWeekEvent(monday, 'graph-low', -10, BadgeKind.body, now);
    }
  }

  Future<List<int?>> _calendarScores(DateTime start, DateTime end) async {
    final rows = await database
        .customSelect(
          '''
      SELECT l.local_day,
        SUM(CASE
          WHEN h.category IN ('reduction', 'custom_bad') AND l.quantity > 0 THEN -1
          WHEN h.category IN ('reduction', 'custom_bad') THEN 1
          WHEN l.quantity > 0 THEN 1
          ELSE -1
        END) AS score
      FROM habit_log_entries l
      JOIN habit_definitions h ON h.id = l.habit_id
      WHERE l.deleted_at IS NULL AND l.local_day >= ? AND l.local_day < ?
      GROUP BY l.local_day
      ''',
          variables: [Variable(start), Variable(end)],
          readsFrom: {database.habitLogEntries, database.habitDefinitions},
        )
        .get();
    final byDay = {
      for (final row in rows)
        _key(row.read<DateTime>('local_day')): row.read<int>('score'),
    };
    return [
      for (var offset = 0; offset < 7; offset++)
        byDay[_key(start.add(Duration(days: offset)))],
    ];
  }

  Future<_ReductionWeekResult> _reductionWeek(
    DateTime start,
    DateTime end,
  ) async {
    final plans =
        await (database.select(database.reductionPlans)..where(
              (row) => row.isActive.equals(true) & row.deletedAt.isNull(),
            ))
            .get();
    if (plans.isEmpty) return const _ReductionWeekResult();
    var violations = 0;
    var trackedAll = true;
    for (final planRow in plans) {
      final logs =
          await (database.select(database.habitLogEntries)..where(
                (row) =>
                    row.habitId.equals(planRow.habitId) &
                    row.localDay.isBiggerOrEqualValue(planRow.startedOn) &
                    row.localDay.isSmallerThanValue(end) &
                    row.deletedAt.isNull(),
              ))
              .get();
      final counts = <DateTime, int>{};
      for (final log in logs) {
        final day = _day(log.localDay);
        counts[day] = (counts[day] ?? 0) + log.quantity;
      }
      final plan = ReductionCalendarData(
        planId: planRow.id,
        habitId: planRow.habitId,
        habitNameKey: planRow.habitId,
        mode: planRow.mode,
        startedOn: _day(planRow.startedOn),
        logCounts: counts,
      );
      for (var offset = 0; offset < 7; offset++) {
        final day = start.add(Duration(days: offset));
        if (day.isBefore(plan.startedOn)) continue;
        trackedAll = trackedAll && plan.hasStatusOn(day);
        if (isReductionViolation(plan, day)) violations++;
      }
    }
    return _ReductionWeekResult(
      trackedAllDays: trackedAll,
      violations: violations,
    );
  }

  Future<_BodyWeekMetrics> _bodyMetrics(DateTime start, DateTime end) async {
    final rows =
        await (database.select(database.graphHistoryEntries)..where(
              (row) =>
                  row.localDay.isBiggerOrEqualValue(start) &
                  row.localDay.isSmallerThanValue(end) &
                  row.metricKey.isIn(const [
                    'organ_min_level',
                    'organ_max_level',
                    'muscle_min_level',
                  ]) &
                  row.deletedAt.isNull(),
            ))
            .get();
    final latest = <String, double>{};
    for (final row in rows) {
      latest['${row.metricKey}:${_key(row.localDay)}'] = row.value;
    }
    var healthy = 0;
    var poor = 0;
    for (var offset = 0; offset < 7; offset++) {
      final key = _key(start.add(Duration(days: offset)));
      if ((latest['organ_min_level:$key'] ?? 0) >= 4) healthy++;
      if ((latest['organ_max_level:$key'] ?? 6) <= 2) poor++;
    }
    final muscleRows =
        rows.where((row) => row.metricKey == 'muscle_min_level').toList()
          ..sort((a, b) => a.localDay.compareTo(b.localDay));
    return _BodyWeekMetrics(
      healthyOrganDays: healthy,
      poorOrganDays: poor,
      musclesAtLeastGreen: muscleRows.isNotEmpty && muscleRows.last.value >= 4,
    );
  }

  Future<List<int>> _customGraphDayTotals(DateTime start, DateTime end) async {
    final rules = await database.select(database.customGraphRules).get();
    final logs =
        await (database.select(database.habitLogEntries)..where(
              (row) =>
                  row.localDay.isBiggerOrEqualValue(start) &
                  row.localDay.isSmallerThanValue(end) &
                  row.deletedAt.isNull(),
            ))
            .get();
    final quantities = <String, int>{};
    final recorded = <String>{};
    for (final log in logs) {
      final key = '${log.habitId}:${_key(log.localDay)}';
      recorded.add(key);
      quantities[key] = (quantities[key] ?? 0) + log.quantity;
    }
    return [
      for (var offset = 0; offset < 7; offset++)
        rules.fold<int>(0, (total, rule) {
          final key =
              '${rule.habitId}:${_key(start.add(Duration(days: offset)))}';
          if (!recorded.contains(key)) return total;
          final didHabit = (quantities[key] ?? 0) > 0;
          return total + (didHabit ? rule.completedPoints : rule.missedPoints);
        }),
    ];
  }

  Future<void> _badgeWeekEvent(
    DateTime week,
    String suffix,
    int amount,
    BadgeKind badge,
    DateTime now,
  ) {
    return _applyEvent(
      id: 'week:${_key(week)}:$suffix',
      amount: amount,
      badge: badge,
      occurredOn: week.add(const Duration(days: 6)),
      now: now,
    ).then((_) {});
  }

  Future<bool> _applyEvent({
    required String id,
    required int amount,
    required DateTime occurredOn,
    required DateTime now,
    BadgeKind? badge,
  }) async {
    return database.transaction(() async {
      final existing = await (database.select(
        database.rewardEvents,
      )..where((row) => row.id.equals(id))).getSingleOrNull();
      if (existing != null) return false;
      final state = await _loadState();
      var profile = state.profileProgress;
      var body = state.bodyProgress;
      var calendar = state.calendarProgress;
      switch (badge) {
        case BadgeKind.profile:
          profile = (profile + amount).clamp(0, 800);
          break;
        case BadgeKind.body:
          body = (body + amount).clamp(0, 500);
          break;
        case BadgeKind.calendar:
          calendar = (calendar + amount).clamp(0, 500);
          break;
        case null:
          break;
      }
      await database
          .into(database.rewardEvents)
          .insert(
            RewardEventsCompanion.insert(
              id: id,
              badgeKey: Value(badge?.name),
              amount: amount,
              occurredOn: occurredOn,
              createdAt: now,
            ),
          );
      await (database.update(
        database.rewardStates,
      )..where((row) => row.id.equals(1))).write(
        RewardStatesCompanion(
          tokenBalance: Value(math.max(0, state.tokenBalance + amount)),
          profileProgress: Value(profile),
          bodyProgress: Value(body),
          calendarProgress: Value(calendar),
          updatedAt: Value(now),
        ),
      );
      return true;
    });
  }

  Future<void> _awardCompletedBadges(DateTime today, DateTime now) async {
    final state = await _loadState();
    if (state.bodyProgress >= 500) {
      await _applyEvent(
        id: 'badge-complete:body:bronze',
        amount: 70,
        badge: BadgeKind.profile,
        occurredOn: today,
        now: now,
      );
    }
    if (state.calendarProgress >= 500) {
      await _applyEvent(
        id: 'badge-complete:calendar:bronze',
        amount: 70,
        badge: BadgeKind.profile,
        occurredOn: today,
        now: now,
      );
    }
  }

  Future<RewardStateRow> _loadState() {
    return (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingle();
  }

  Future<Set<DateTime>> _loadActivityDays() async {
    final rows = await database
        .customSelect(
          'SELECT DISTINCT local_day FROM habit_log_entries WHERE deleted_at IS NULL',
          readsFrom: {database.habitLogEntries},
        )
        .get();
    return {for (final row in rows) _day(row.read<DateTime>('local_day'))};
  }

  Future<DateTime?> _firstCompletedWeek(DateTime currentWeek) async {
    final days = await _loadActivityDays();
    if (days.isEmpty) return null;
    final first = days.reduce((a, b) => a.isBefore(b) ? a : b);
    final week = _monday(first);
    return week.isBefore(currentWeek) ? week : null;
  }

  static _StreakResult _calculateStreak(Set<DateTime> days, DateTime today) {
    var cursor = days.contains(today)
        ? today
        : today.subtract(const Duration(days: 1));
    var length = 0;
    while (days.contains(cursor)) {
      length++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return _StreakResult(
      length: length,
      start: length == 0 ? null : cursor.add(const Duration(days: 1)),
    );
  }

  static DateTime _day(DateTime value) =>
      DateTime(value.year, value.month, value.day);
  static DateTime _monday(DateTime day) =>
      day.subtract(Duration(days: day.weekday - 1));
  static DateTime _nextMonday(DateTime day) =>
      _monday(day).add(const Duration(days: 7));
  static String _key(DateTime day) =>
      '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
}

class _StreakResult {
  const _StreakResult({required this.length, required this.start});
  final int length;
  final DateTime? start;
}

class _ReductionWeekResult {
  const _ReductionWeekResult({
    this.trackedAllDays = false,
    this.violations = 0,
  });
  final bool trackedAllDays;
  final int violations;
}

class _BodyWeekMetrics {
  const _BodyWeekMetrics({
    required this.healthyOrganDays,
    required this.poorOrganDays,
    required this.musclesAtLeastGreen,
  });
  final int healthyOrganDays;
  final int poorOrganDays;
  final bool musclesAtLeastGreen;
}
