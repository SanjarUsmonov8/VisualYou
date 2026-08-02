import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_models.dart';

abstract interface class ReductionCalendarRepository {
  Future<List<ReductionHabit>> loadUnwantedHabits();

  Future<void> createHardPlan({required String habitId, DateTime? startedOn});

  Future<void> createMediumPlan({required String habitId, DateTime? startedOn});

  Future<void> createEasyPlan({required String habitId, DateTime? startedOn});

  Future<void> setDayStatus({
    required String planId,
    required DateTime day,
    required bool didHabit,
  });

  Stream<ReductionCalendarData?> watchMonth(DateTime month);

  Stream<List<ReductionCalendarData>> watchPlansMonth(DateTime month);
}

class DriftReductionCalendarRepository implements ReductionCalendarRepository {
  DriftReductionCalendarRepository(this.database);

  final AppDatabase database;

  @override
  Future<List<ReductionHabit>> loadUnwantedHabits() async {
    final query = database.select(database.habitDefinitions)
      ..where(
        (habit) =>
            habit.category.equals('reduction') &
            habit.isActive.equals(true) &
            habit.deletedAt.isNull(),
      )
      ..orderBy([(habit) => OrderingTerm.asc(habit.nameKey)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        ReductionHabit(
          id: row.id,
          nameKey: row.nameKey,
          category: row.category,
        ),
    ];
  }

  @override
  Future<void> createHardPlan({required String habitId, DateTime? startedOn}) {
    return _createPlan(habitId: habitId, mode: 'hard', startedOn: startedOn);
  }

  @override
  Future<void> createMediumPlan({
    required String habitId,
    DateTime? startedOn,
  }) {
    return _createPlan(habitId: habitId, mode: 'medium', startedOn: startedOn);
  }

  @override
  Future<void> createEasyPlan({required String habitId, DateTime? startedOn}) {
    return _createPlan(habitId: habitId, mode: 'easy', startedOn: startedOn);
  }

  Future<void> _createPlan({
    required String habitId,
    required String mode,
    DateTime? startedOn,
  }) async {
    final now = DateTime.now();
    final startValue = startedOn ?? now;
    final startDay = DateTime(
      startValue.year,
      startValue.month,
      startValue.day,
    );
    await database.transaction(() async {
      await database
          .update(database.reductionPlans)
          .write(
            ReductionPlansCompanion(
              isActive: const Value(false),
              updatedAt: Value(now),
            ),
          );

      await database
          .into(database.reductionPlans)
          .insert(
            ReductionPlansCompanion.insert(
              id: '$mode:${now.microsecondsSinceEpoch}',
              habitId: habitId,
              mode: mode,
              startedOn: startDay,
              createdAt: now,
              updatedAt: now,
            ),
          );
    });
  }

  @override
  Future<void> setDayStatus({
    required String planId,
    required DateTime day,
    required bool didHabit,
  }) async {
    final plan = await (database.select(
      database.reductionPlans,
    )..where((row) => row.id.equals(planId))).getSingle();
    final now = DateTime.now();
    final localDay = DateTime(day.year, day.month, day.day);

    await database.transaction(() async {
      await (database.update(database.habitLogEntries)..where(
            (entry) =>
                entry.habitId.equals(plan.habitId) &
                entry.localDay.equals(localDay) &
                entry.deletedAt.isNull(),
          ))
          .write(
            HabitLogEntriesCompanion(
              deletedAt: Value(now),
              updatedAt: Value(now),
              syncStatus: const Value('pending'),
            ),
          );

      if (didHabit) {
        await database
            .into(database.habitLogEntries)
            .insert(
              HabitLogEntriesCompanion.insert(
                id: 'reduction:$planId:${localDay.microsecondsSinceEpoch}:${now.microsecondsSinceEpoch}',
                habitId: plan.habitId,
                loggedAt: now,
                localDay: localDay,
                createdAt: now,
                updatedAt: now,
              ),
            );
      }
    });
  }

  @override
  Stream<ReductionCalendarData?> watchMonth(DateTime month) {
    return watchPlansMonth(
      month,
    ).map((plans) => plans.isEmpty ? null : plans.first);
  }

  @override
  Stream<List<ReductionCalendarData>> watchPlansMonth(DateTime month) {
    final query = database.customSelect(
      '''
      SELECT
        p.id,
        p.habit_id,
        p.mode,
        p.started_on,
        h.name_key,
        l.local_day,
        COALESCE(SUM(l.quantity), 0) AS habit_count
      FROM reduction_plans AS p
      INNER JOIN habit_definitions AS h ON h.id = p.habit_id
      LEFT JOIN habit_log_entries AS l
        ON l.habit_id = p.habit_id
        AND l.deleted_at IS NULL
      WHERE p.is_active = 1
        AND p.deleted_at IS NULL
      GROUP BY
        p.id, p.habit_id, p.mode, p.started_on, h.name_key, l.local_day
      ORDER BY p.created_at DESC, l.local_day
      ''',
      readsFrom: {
        database.reductionPlans,
        database.habitDefinitions,
        database.habitLogEntries,
      },
    );
    return query.watch().map((rows) {
      final rowsByPlan = <String, List<QueryRow>>{};
      for (final row in rows) {
        rowsByPlan.putIfAbsent(row.read<String>('id'), () => []).add(row);
      }
      return [
        for (final planRows in rowsByPlan.values.take(1))
          _mapPlanRows(planRows),
      ];
    });
  }

  ReductionCalendarData _mapPlanRows(List<QueryRow> rows) {
    final first = rows.first;
    final logCounts = <DateTime, int>{};
    for (final row in rows) {
      final storedDay = row.readNullable<DateTime>('local_day');
      if (storedDay != null) {
        logCounts[DateTime(storedDay.year, storedDay.month, storedDay.day)] =
            row.read<int>('habit_count');
      }
    }
    final storedStart = first.read<DateTime>('started_on');
    return ReductionCalendarData(
      planId: first.read<String>('id'),
      habitId: first.read<String>('habit_id'),
      habitNameKey: first.read<String>('name_key'),
      mode: first.read<String>('mode'),
      startedOn: DateTime(storedStart.year, storedStart.month, storedStart.day),
      logCounts: logCounts,
    );
  }
}
