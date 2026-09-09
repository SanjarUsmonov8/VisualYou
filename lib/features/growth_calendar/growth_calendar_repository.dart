import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/growth_calendar/growth_calendar_models.dart';

abstract interface class GrowthCalendarRepository {
  Future<List<GrowthHabit>> loadGoodHabits();

  Future<void> createPlan({
    required String habitId,
    required GrowthMode mode,
    required DateTime startedOn,
    required int targetDaysPerWeek,
    required int targetRepetitionsPerDay,
    required Set<int> offWeekdays,
    Map<int, int> weekdayRepetitions = const {},
    GrowthMeasurementUnit measurementUnit = GrowthMeasurementUnit.times,
  });

  Future<void> deactivatePlan(String planId);

  Future<void> setDayCount({
    required String planId,
    required DateTime day,
    required int completedCount,
  });

  Stream<List<GrowthCalendarData>> watchPlansMonth(DateTime month);
}

class DriftGrowthCalendarRepository implements GrowthCalendarRepository {
  DriftGrowthCalendarRepository(this.database);

  final AppDatabase database;

  @override
  Future<List<GrowthHabit>> loadGoodHabits() async {
    final query = database.select(database.habitDefinitions)
      ..where(
        (habit) =>
            habit.category.isIn(const ['good', 'exercise', 'custom_good']) &
            habit.isActive.equals(true) &
            habit.deletedAt.isNull(),
      )
      ..orderBy([(habit) => OrderingTerm.asc(habit.nameKey)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        GrowthHabit(
          id: row.id,
          nameKey: row.nameKey,
          category: row.category,
          numericalTrackingEnabled: row.numericalTrackingEnabled,
          numericalUnit: row.numericalUnit,
        ),
    ];
  }

  @override
  Future<void> createPlan({
    required String habitId,
    required GrowthMode mode,
    required DateTime startedOn,
    required int targetDaysPerWeek,
    required int targetRepetitionsPerDay,
    required Set<int> offWeekdays,
    Map<int, int> weekdayRepetitions = const {},
    GrowthMeasurementUnit measurementUnit = GrowthMeasurementUnit.times,
  }) async {
    final now = DateTime.now();
    final startDay = DateTime(startedOn.year, startedOn.month, startedOn.day);
    final normalizedOffDays =
        offWeekdays.where((day) => day >= 1 && day <= 7).toList()..sort();
    final normalizedOverrides =
        weekdayRepetitions.entries
            .where(
              (entry) =>
                  entry.key >= 1 &&
                  entry.key <= 7 &&
                  entry.value >= 1 &&
                  entry.value <=
                      (measurementUnit == GrowthMeasurementUnit.minutes
                          ? 1440
                          : 99),
            )
            .toList()
          ..sort((first, second) => first.key.compareTo(second.key));
    await database
        .into(database.growthPlans)
        .insert(
          GrowthPlansCompanion.insert(
            id: 'growth:${now.microsecondsSinceEpoch}',
            habitId: habitId,
            mode: mode.name,
            startedOn: startDay,
            targetDaysPerWeek: targetDaysPerWeek.clamp(1, 7),
            targetRepetitionsPerDay: targetRepetitionsPerDay.clamp(
              1,
              measurementUnit == GrowthMeasurementUnit.minutes ? 1440 : 99,
            ),
            offWeekdays: Value(normalizedOffDays.join(',')),
            weekdayRepetitions: Value(
              normalizedOverrides
                  .map((entry) => '${entry.key}:${entry.value}')
                  .join(','),
            ),
            measurementUnit: Value(measurementUnit.name),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> deactivatePlan(String planId) async {
    await (database.update(
      database.growthPlans,
    )..where((plan) => plan.id.equals(planId))).write(
      GrowthPlansCompanion(
        isActive: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> setDayCount({
    required String planId,
    required DateTime day,
    required int completedCount,
  }) async {
    final now = DateTime.now();
    final localDay = DateTime(day.year, day.month, day.day);
    await database
        .into(database.growthPlanEntries)
        .insertOnConflictUpdate(
          GrowthPlanEntriesCompanion.insert(
            planId: planId,
            localDay: localDay,
            completedCount: Value(completedCount.clamp(0, 1440)),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Stream<List<GrowthCalendarData>> watchPlansMonth(DateTime month) {
    final query = database.customSelect(
      '''
      SELECT
        p.id,
        p.habit_id,
        p.mode,
        p.started_on,
        p.target_days_per_week,
        p.target_repetitions_per_day,
        p.off_weekdays,
        p.weekday_repetitions,
        p.measurement_unit,
        h.name_key,
        e.local_day,
        e.completed_count
      FROM growth_plans AS p
      INNER JOIN habit_definitions AS h ON h.id = p.habit_id
      LEFT JOIN growth_plan_entries AS e ON e.plan_id = p.id
      WHERE p.is_active = 1
        AND p.deleted_at IS NULL
      ORDER BY p.created_at ASC, e.local_day
      ''',
      readsFrom: {
        database.growthPlans,
        database.growthPlanEntries,
        database.habitDefinitions,
      },
    );
    return query.watch().map((rows) {
      final rowsByPlan = <String, List<QueryRow>>{};
      for (final row in rows) {
        rowsByPlan.putIfAbsent(row.read<String>('id'), () => []).add(row);
      }
      return [for (final rows in rowsByPlan.values) _mapPlanRows(rows)];
    });
  }

  GrowthCalendarData _mapPlanRows(List<QueryRow> rows) {
    final first = rows.first;
    final counts = <DateTime, int>{};
    for (final row in rows) {
      final day = row.readNullable<DateTime>('local_day');
      if (day != null) {
        counts[DateTime(day.year, day.month, day.day)] =
            row.readNullable<int>('completed_count') ?? 0;
      }
    }
    final storedStart = first.read<DateTime>('started_on');
    final offDays = first
        .read<String>('off_weekdays')
        .split(',')
        .map(int.tryParse)
        .whereType<int>()
        .where((day) => day >= 1 && day <= 7)
        .toSet();
    final weekdayRepetitions = <int, int>{};
    for (final pair in first.read<String>('weekday_repetitions').split(',')) {
      final pieces = pair.split(':');
      if (pieces.length != 2) continue;
      final weekday = int.tryParse(pieces[0]);
      final repetitions = int.tryParse(pieces[1]);
      if (weekday != null &&
          repetitions != null &&
          weekday >= 1 &&
          weekday <= 7 &&
          repetitions >= 1) {
        weekdayRepetitions[weekday] = repetitions;
      }
    }
    return GrowthCalendarData(
      planId: first.read<String>('id'),
      habitId: first.read<String>('habit_id'),
      habitNameKey: first.read<String>('name_key'),
      mode: GrowthMode.values.firstWhere(
        (mode) => mode.name == first.read<String>('mode'),
        orElse: () => GrowthMode.fast,
      ),
      startedOn: DateTime(storedStart.year, storedStart.month, storedStart.day),
      targetDaysPerWeek: first.read<int>('target_days_per_week'),
      targetRepetitionsPerDay: first.read<int>('target_repetitions_per_day'),
      offWeekdays: offDays,
      weekdayRepetitions: weekdayRepetitions,
      measurementUnit: GrowthMeasurementUnit.values.firstWhere(
        (unit) => unit.name == first.read<String>('measurement_unit'),
        orElse: () => GrowthMeasurementUnit.times,
      ),
      completedCounts: counts,
    );
  }
}
