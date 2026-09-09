import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/custom_graph/custom_graph_models.dart';
import 'package:visualyou/features/numerical_habits/numerical_habit_config.dart';

abstract interface class CustomGraphRepository {
  Future<List<CustomGraphHabit>> loadHabits();

  Future<List<CustomGraphRule>> loadRules();

  Future<void> saveRules(List<CustomGraphRule> rules);

  Stream<CustomGraphSnapshot> watchSnapshot({
    DateTime? endingOn,
    int dayCount = 7,
  });

  Future<void> saveSpecialHabit({
    required int slot,
    String? habitId,
    int completedValue = 1,
    int missedValue = -1,
  });

  Stream<List<SpecialHabitGraph>> watchSpecialHabitGraphs({
    DateTime? endingOn,
    int dayCount = 7,
  });

  Stream<List<NamedCustomGraph>> watchNamedGraphs({
    DateTime? endingOn,
    int dayCount = 7,
  });

  Future<void> saveNamedGraph({
    required int graphSlot,
    required String name,
    required List<CustomGraphRule> rules,
  });

  Future<bool> isNamedGraphUnlocked(int graphSlot);

  Future<void> unlockNamedGraph(int graphSlot);
}

class DriftCustomGraphRepository implements CustomGraphRepository {
  DriftCustomGraphRepository(this.database);

  final AppDatabase database;

  @override
  Future<List<CustomGraphHabit>> loadHabits() async {
    final query = database.select(database.habitDefinitions)
      ..where((habit) => habit.isActive.equals(true) & habit.deletedAt.isNull())
      ..orderBy([(habit) => OrderingTerm.asc(habit.nameKey)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        CustomGraphHabit(
          id: row.id,
          nameKey: row.nameKey,
          category: row.category,
          numericalTrackingEnabled: row.numericalTrackingEnabled,
          numericalUnit: row.numericalUnit,
        ),
    ];
  }

  @override
  Future<List<CustomGraphRule>> loadRules() async {
    final query = database.select(database.customGraphRules).join([
      innerJoin(
        database.habitDefinitions,
        database.habitDefinitions.id.equalsExp(
          database.customGraphRules.habitId,
        ),
      ),
    ])..orderBy([OrderingTerm.asc(database.customGraphRules.slot)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        CustomGraphRule(
          slot: row.readTable(database.customGraphRules).slot,
          habitId: row.readTable(database.customGraphRules).habitId,
          habitNameKey: row.readTable(database.habitDefinitions).nameKey,
          completedPoints: row
              .readTable(database.customGraphRules)
              .completedPoints,
          missedPoints: row.readTable(database.customGraphRules).missedPoints,
        ),
    ];
  }

  @override
  Future<void> saveRules(List<CustomGraphRule> rules) async {
    final rewards = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    if (rewards != null) {
      final activePlan = rewards.planExpiresAt?.isBefore(DateTime.now()) == true
          ? 'free'
          : rewards.plan;
      final limit = switch (activePlan) {
        'free' => 3,
        'plus' => 6,
        'pro' => 10,
        'ultra' => null,
        _ => 3,
      };
      if (limit != null && rules.any((rule) => rule.slot >= limit)) {
        throw StateError('The current plan does not allow this graph slot.');
      }
    }
    final now = DateTime.now();
    await database.transaction(() async {
      await database.delete(database.customGraphRules).go();
      await database.batch((batch) {
        for (final rule in rules) {
          batch.insert(
            database.customGraphRules,
            CustomGraphRulesCompanion.insert(
              slot: Value(rule.slot),
              habitId: rule.habitId,
              completedPoints: rule.completedPoints,
              missedPoints: rule.missedPoints,
              updatedAt: now,
            ),
          );
        }
      });
    });
  }

  @override
  Stream<CustomGraphSnapshot> watchSnapshot({
    DateTime? endingOn,
    int dayCount = 7,
  }) {
    final todayValue = endingOn ?? DateTime.now();
    final today = DateTime(todayValue.year, todayValue.month, todayValue.day);
    final safeDayCount = dayCount.clamp(1, 3660);
    final firstDay = today.subtract(Duration(days: safeDayCount - 1));
    final query = database.customSelect(
      '''
      SELECT
        r.slot,
        r.habit_id,
        r.completed_points,
        r.missed_points,
        h.name_key,
        l.local_day,
        COALESCE(SUM(l.quantity), 0) AS habit_count
      FROM custom_graph_rules AS r
      INNER JOIN habit_definitions AS h ON h.id = r.habit_id
      LEFT JOIN habit_log_entries AS l
        ON l.habit_id = r.habit_id
        AND l.deleted_at IS NULL
        AND l.local_day >= ?
        AND l.local_day <= ?
      GROUP BY r.slot, r.habit_id, r.completed_points, r.missed_points,
        h.name_key, l.local_day
      ORDER BY r.slot
      ''',
      variables: [Variable(firstDay), Variable(today)],
      readsFrom: {
        database.customGraphRules,
        database.habitDefinitions,
        database.habitLogEntries,
      },
    );
    return query.watch().map(
      (rows) => _snapshotFromRows(
        rows: rows,
        firstDay: firstDay,
        dayCount: safeDayCount,
      ),
    );
  }

  @override
  Future<void> saveSpecialHabit({
    required int slot,
    String? habitId,
    int completedValue = 1,
    int missedValue = -1,
  }) async {
    await (database.delete(
      database.specialHabitGraphs,
    )..where((graph) => graph.slot.equals(slot))).go();
    if (habitId == null) return;
    await database
        .into(database.specialHabitGraphs)
        .insert(
          SpecialHabitGraphsCompanion.insert(
            slot: Value(slot),
            habitId: habitId,
            completedValue: Value(completedValue),
            missedValue: Value(missedValue),
            updatedAt: DateTime.now(),
          ),
        );
  }

  @override
  Stream<List<SpecialHabitGraph>> watchSpecialHabitGraphs({
    DateTime? endingOn,
    int dayCount = 7,
  }) {
    final todayValue = endingOn ?? DateTime.now();
    final today = DateTime(todayValue.year, todayValue.month, todayValue.day);
    final safeDayCount = dayCount.clamp(1, 3660);
    final firstDay = today.subtract(Duration(days: safeDayCount - 1));
    final query = database.customSelect(
      '''
      SELECT
        s.slot,
        s.habit_id,
        s.completed_value,
        s.missed_value,
        h.name_key,
        h.numerical_tracking_enabled,
        h.numerical_unit,
        h.category,
        l.local_day,
        COALESCE(SUM(CASE WHEN l.quantity > 0 THEN 1 ELSE 0 END), 0)
          AS completed_count,
        COALESCE(SUM(CASE WHEN l.quantity = 0 THEN 1 ELSE 0 END), 0)
          AS missed_count,
        n.value AS numerical_value,
        n.actual_did_habit AS numerical_did_habit
      FROM special_habit_graphs AS s
      INNER JOIN habit_definitions AS h ON h.id = s.habit_id
      LEFT JOIN habit_log_entries AS l
        ON l.habit_id = s.habit_id
        AND l.deleted_at IS NULL
        AND l.local_day >= ?
        AND l.local_day <= ?
      LEFT JOIN numerical_habit_entries AS n
        ON n.habit_id = s.habit_id
        AND n.local_day = l.local_day
      GROUP BY s.slot, s.habit_id, s.completed_value, s.missed_value,
        h.name_key, h.numerical_tracking_enabled, h.numerical_unit,
        h.category, l.local_day,
        n.value, n.actual_did_habit
      ORDER BY s.slot, l.local_day
      ''',
      variables: [Variable(firstDay), Variable(today)],
      readsFrom: {
        database.specialHabitGraphs,
        database.habitDefinitions,
        database.habitLogEntries,
        database.numericalHabitEntries,
      },
    );
    return query.watch().map(
      (rows) => _specialGraphsFromRows(
        rows: rows,
        firstDay: firstDay,
        dayCount: safeDayCount,
      ),
    );
  }

  @override
  Stream<List<NamedCustomGraph>> watchNamedGraphs({
    DateTime? endingOn,
    int dayCount = 7,
  }) {
    final todayValue = endingOn ?? DateTime.now();
    final today = DateTime(todayValue.year, todayValue.month, todayValue.day);
    final safeDayCount = dayCount.clamp(1, 3660);
    final firstDay = today.subtract(Duration(days: safeDayCount - 1));
    final query = database.customSelect(
      '''
      SELECT
        g.slot AS graph_slot,
        g.name AS graph_name,
        r.rule_slot,
        r.habit_id,
        r.completed_points,
        r.missed_points,
        h.name_key,
        l.local_day,
        COALESCE(SUM(l.quantity), 0) AS habit_count
      FROM named_custom_graphs AS g
      LEFT JOIN named_custom_graph_rules AS r ON r.graph_slot = g.slot
      LEFT JOIN habit_definitions AS h ON h.id = r.habit_id
      LEFT JOIN habit_log_entries AS l
        ON l.habit_id = r.habit_id
        AND l.deleted_at IS NULL
        AND l.local_day >= ?
        AND l.local_day <= ?
      GROUP BY g.slot, g.name, r.rule_slot, r.habit_id,
        r.completed_points, r.missed_points, h.name_key, l.local_day
      ORDER BY g.slot, r.rule_slot
      ''',
      variables: [Variable(firstDay), Variable(today)],
      readsFrom: {
        database.namedCustomGraphs,
        database.namedCustomGraphRules,
        database.habitDefinitions,
        database.habitLogEntries,
      },
    );
    return query.watch().map(
      (rows) => _namedGraphsFromRows(
        rows: rows,
        firstDay: firstDay,
        dayCount: safeDayCount,
      ),
    );
  }

  @override
  Future<void> saveNamedGraph({
    required int graphSlot,
    required String name,
    required List<CustomGraphRule> rules,
  }) async {
    final trimmedName = name.trim();
    if (graphSlot < 0 || trimmedName.isEmpty) {
      throw ArgumentError('A group graph needs a valid slot and name.');
    }
    if (rules.map((rule) => rule.habitId).toSet().length != rules.length) {
      throw ArgumentError('Group graph habits must be different.');
    }
    await _validateNamedGraphAccess(graphSlot);
    final now = DateTime.now();
    await database.transaction(() async {
      await database
          .into(database.namedCustomGraphs)
          .insertOnConflictUpdate(
            NamedCustomGraphsCompanion.insert(
              slot: Value(graphSlot),
              name: trimmedName,
              updatedAt: now,
            ),
          );
      await (database.delete(
        database.namedCustomGraphRules,
      )..where((row) => row.graphSlot.equals(graphSlot))).go();
      for (final rule in rules) {
        await database
            .into(database.namedCustomGraphRules)
            .insert(
              NamedCustomGraphRulesCompanion.insert(
                graphSlot: graphSlot,
                ruleSlot: rule.slot,
                habitId: rule.habitId,
                completedPoints: rule.completedPoints,
                missedPoints: rule.missedPoints,
                updatedAt: now,
              ),
            );
      }
    });
  }

  @override
  Future<bool> isNamedGraphUnlocked(int graphSlot) async {
    final row =
        await (database.select(database.featureUnlocks)..where(
              (unlock) =>
                  unlock.featureKey.equals('named-custom-graph-$graphSlot'),
            ))
            .getSingleOrNull();
    return row?.unlockedUntil.isAfter(DateTime.now()) == true;
  }

  @override
  Future<void> unlockNamedGraph(int graphSlot) async {
    final now = DateTime.now();
    await database
        .into(database.featureUnlocks)
        .insertOnConflictUpdate(
          FeatureUnlocksCompanion.insert(
            featureKey: 'named-custom-graph-$graphSlot',
            unlockedUntil: now.add(const Duration(days: 7)),
            updatedAt: now,
          ),
        );
  }

  Future<void> _validateNamedGraphAccess(int graphSlot) async {
    final now = DateTime.now();
    final rewards = await (database.select(
      database.rewardStates,
    )..where((row) => row.id.equals(1))).getSingleOrNull();
    final plan = rewards == null || rewards.planExpiresAt?.isBefore(now) == true
        ? 'free'
        : rewards.plan;
    final included = switch (plan) {
      'pro' => graphSlot >= 0 && graphSlot < 2,
      'ultra' => graphSlot >= 0 && graphSlot < 6,
      _ => false,
    };
    final paidSlot = switch (plan) {
      'plus' => graphSlot == 0,
      'pro' => graphSlot >= 2 && graphSlot < 4,
      _ => false,
    };
    if (included) return;
    if (paidSlot && await isNamedGraphUnlocked(graphSlot)) return;
    throw StateError('This group graph is locked for the current plan.');
  }

  static List<NamedCustomGraph> _namedGraphsFromRows({
    required List<QueryRow> rows,
    required DateTime firstDay,
    required int dayCount,
  }) {
    final groupedRows = <int, List<QueryRow>>{};
    for (final row in rows) {
      groupedRows.putIfAbsent(row.read<int>('graph_slot'), () => []).add(row);
    }
    return [
      for (final entry in groupedRows.entries)
        NamedCustomGraph(
          slot: entry.key,
          name: entry.value.first.read<String>('graph_name'),
          snapshot: _snapshotFromNamedRows(
            rows: entry.value,
            firstDay: firstDay,
            dayCount: dayCount,
          ),
        ),
    ]..sort((first, second) => first.slot.compareTo(second.slot));
  }

  static CustomGraphSnapshot _snapshotFromNamedRows({
    required List<QueryRow> rows,
    required DateTime firstDay,
    required int dayCount,
  }) {
    final rules = <CustomGraphRule>[];
    final seenRuleSlots = <int>{};
    final recordedValues = <String, bool>{};
    for (final row in rows) {
      final ruleSlot = row.readNullable<int>('rule_slot');
      final habitId = row.readNullable<String>('habit_id');
      if (ruleSlot == null || habitId == null) continue;
      if (seenRuleSlots.add(ruleSlot)) {
        rules.add(
          CustomGraphRule(
            slot: ruleSlot,
            habitId: habitId,
            habitNameKey: row.read<String>('name_key'),
            completedPoints: row.read<int>('completed_points'),
            missedPoints: row.read<int>('missed_points'),
          ),
        );
      }
      final localDay = row.readNullable<DateTime>('local_day');
      if (localDay != null) {
        recordedValues['$habitId:${_dayKey(localDay)}'] =
            row.read<int>('habit_count') > 0;
      }
    }
    rules.sort((first, second) => first.slot.compareTo(second.slot));
    return CustomGraphSnapshot(
      rules: rules,
      days: [
        for (var offset = 0; offset < dayCount; offset++)
          _buildDay(
            firstDay.add(Duration(days: offset)),
            rules,
            recordedValues,
          ),
      ],
    );
  }

  static List<SpecialHabitGraph> _specialGraphsFromRows({
    required List<QueryRow> rows,
    required DateTime firstDay,
    required int dayCount,
  }) {
    final selectionRows = <int, QueryRow>{};
    final values = <String, int>{};
    for (final row in rows) {
      final slot = row.read<int>('slot');
      selectionRows.putIfAbsent(slot, () => row);
      final day = row.readNullable<DateTime>('local_day');
      if (day != null) {
        final completedValue = row.read<int>('completed_value');
        final missedValue = row.read<int>('missed_value');
        final numericalValue = row.readNullable<int>('numerical_value');
        final numericalDidHabit = row.readNullable<bool>('numerical_did_habit');
        values['$slot:${_dayKey(day)}'] =
            numericalValue ??
            (numericalDidHabit != null
                ? (numericalDidHabit ? completedValue : missedValue)
                : (row.read<int>('completed_count') * completedValue) +
                      (row.read<int>('missed_count') * missedValue));
      }
    }
    return [
      for (final entry in selectionRows.entries)
        SpecialHabitGraph(
          slot: entry.key,
          habitId: entry.value.read<String>('habit_id'),
          habitNameKey: entry.value.read<String>('name_key'),
          completedValue: entry.value.read<int>('completed_value'),
          missedValue: entry.value.read<int>('missed_value'),
          unitKey: entry.value.read<bool>('numerical_tracking_enabled')
              ? numericalConfigForHabit(
                  habitId: entry.value.read<String>('habit_id'),
                  category: entry.value.read<String>('category'),
                  unitKey: entry.value.readNullable<String>('numerical_unit'),
                ).unitKey
              : null,
          days: [
            for (var offset = 0; offset < dayCount; offset++)
              SpecialHabitGraphDay(
                day: firstDay.add(Duration(days: offset)),
                count:
                    values['${entry.key}:${_dayKey(firstDay.add(Duration(days: offset)))}'] ??
                    0,
              ),
          ],
        ),
    ]..sort((first, second) => first.slot.compareTo(second.slot));
  }

  static CustomGraphSnapshot _snapshotFromRows({
    required List<QueryRow> rows,
    required DateTime firstDay,
    required int dayCount,
  }) {
    final rulesById = <String, CustomGraphRule>{};
    final recordedValues = <String, bool>{};
    for (final row in rows) {
      final habitId = row.read<String>('habit_id');
      rulesById.putIfAbsent(
        habitId,
        () => CustomGraphRule(
          slot: row.read<int>('slot'),
          habitId: habitId,
          habitNameKey: row.read<String>('name_key'),
          completedPoints: row.read<int>('completed_points'),
          missedPoints: row.read<int>('missed_points'),
        ),
      );
      final localDay = row.readNullable<DateTime>('local_day');
      if (localDay != null) {
        recordedValues['$habitId:${_dayKey(localDay)}'] =
            row.read<int>('habit_count') > 0;
      }
    }
    final rules = rulesById.values.toList()
      ..sort((first, second) => first.slot.compareTo(second.slot));
    return CustomGraphSnapshot(
      rules: rules,
      days: [
        for (var offset = 0; offset < dayCount; offset++)
          _buildDay(
            firstDay.add(Duration(days: offset)),
            rules,
            recordedValues,
          ),
      ],
    );
  }

  static CustomGraphDay _buildDay(
    DateTime day,
    List<CustomGraphRule> rules,
    Map<String, bool> recordedValues,
  ) {
    return CustomGraphDay(
      day: day,
      values: {
        for (final rule in rules)
          rule.habitId:
              switch (recordedValues['${rule.habitId}:${_dayKey(day)}']) {
                true => rule.completedPoints,
                false => rule.missedPoints,
                null => 0,
              },
      },
    );
  }

  static String _dayKey(DateTime day) {
    final month = day.month.toString().padLeft(2, '0');
    final date = day.day.toString().padLeft(2, '0');
    return '${day.year}-$month-$date';
  }
}
