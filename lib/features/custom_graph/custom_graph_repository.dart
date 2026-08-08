import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/custom_graph/custom_graph_models.dart';

abstract interface class CustomGraphRepository {
  Future<List<CustomGraphHabit>> loadHabits();

  Future<List<CustomGraphRule>> loadRules();

  Future<void> saveRules(List<CustomGraphRule> rules);

  Stream<CustomGraphSnapshot> watchSnapshot();

  Future<void> saveSpecialHabit({required int slot, String? habitId});

  Stream<List<SpecialHabitGraph>> watchSpecialHabitGraphs();
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
  Stream<CustomGraphSnapshot> watchSnapshot() {
    final todayValue = DateTime.now();
    final today = DateTime(todayValue.year, todayValue.month, todayValue.day);
    final firstDay = today.subtract(const Duration(days: 6));
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
      (rows) => _snapshotFromRows(rows: rows, firstDay: firstDay),
    );
  }

  @override
  Future<void> saveSpecialHabit({required int slot, String? habitId}) async {
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
            updatedAt: DateTime.now(),
          ),
        );
  }

  @override
  Stream<List<SpecialHabitGraph>> watchSpecialHabitGraphs() {
    final todayValue = DateTime.now();
    final today = DateTime(todayValue.year, todayValue.month, todayValue.day);
    final firstDay = today.subtract(const Duration(days: 6));
    final query = database.customSelect(
      '''
      SELECT
        s.slot,
        s.habit_id,
        h.name_key,
        l.local_day,
        COALESCE(SUM(l.quantity), 0) AS habit_count
      FROM special_habit_graphs AS s
      INNER JOIN habit_definitions AS h ON h.id = s.habit_id
      LEFT JOIN habit_log_entries AS l
        ON l.habit_id = s.habit_id
        AND l.deleted_at IS NULL
        AND l.local_day >= ?
        AND l.local_day <= ?
      GROUP BY s.slot, s.habit_id, h.name_key, l.local_day
      ORDER BY s.slot, l.local_day
      ''',
      variables: [Variable(firstDay), Variable(today)],
      readsFrom: {
        database.specialHabitGraphs,
        database.habitDefinitions,
        database.habitLogEntries,
      },
    );
    return query.watch().map(
      (rows) => _specialGraphsFromRows(rows: rows, firstDay: firstDay),
    );
  }

  static List<SpecialHabitGraph> _specialGraphsFromRows({
    required List<QueryRow> rows,
    required DateTime firstDay,
  }) {
    final selectionRows = <int, QueryRow>{};
    final counts = <String, int>{};
    for (final row in rows) {
      final slot = row.read<int>('slot');
      selectionRows.putIfAbsent(slot, () => row);
      final day = row.readNullable<DateTime>('local_day');
      if (day != null) {
        counts['$slot:${_dayKey(day)}'] = row.read<int>('habit_count');
      }
    }
    return [
      for (final entry in selectionRows.entries)
        SpecialHabitGraph(
          slot: entry.key,
          habitId: entry.value.read<String>('habit_id'),
          habitNameKey: entry.value.read<String>('name_key'),
          days: [
            for (var offset = 0; offset < 7; offset++)
              SpecialHabitGraphDay(
                day: firstDay.add(Duration(days: offset)),
                count:
                    counts['${entry.key}:${_dayKey(firstDay.add(Duration(days: offset)))}'] ??
                    0,
              ),
          ],
        ),
    ]..sort((first, second) => first.slot.compareTo(second.slot));
  }

  static CustomGraphSnapshot _snapshotFromRows({
    required List<QueryRow> rows,
    required DateTime firstDay,
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
        for (var offset = 0; offset < 7; offset++)
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
