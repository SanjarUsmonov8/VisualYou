import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/habit_streak/habit_streak_models.dart';

abstract interface class HabitStreakRepository {
  Stream<List<HabitStreakData>> watchStreaks();

  Future<List<HabitStreakHabit>> loadAvailableHabits();

  Future<void> createStreak(String habitId, {int? colorValue});

  Future<void> updateColor(String habitId, int? colorValue);

  Future<void> deleteStreak(String habitId);
}

class DriftHabitStreakRepository implements HabitStreakRepository {
  DriftHabitStreakRepository(this.database);

  final AppDatabase database;

  @override
  Stream<List<HabitStreakData>> watchStreaks() {
    final query = database.customSelect(
      '''
      WITH latest_logs AS (
        SELECT
          l.*,
          ROW_NUMBER() OVER (
            PARTITION BY l.habit_id, l.local_day
            ORDER BY l.updated_at DESC, l.created_at DESC, l.id DESC
          ) AS position
        FROM habit_log_entries AS l
        WHERE l.deleted_at IS NULL
      )
      SELECT
        s.habit_id,
        s.color_value,
        s.created_at,
        h.name_key,
        h.category,
        l.local_day,
        l.quantity AS habit_quantity,
        CASE WHEN n.id IS NOT NULL THEN 1 ELSE 0 END AS has_numerical,
        CASE WHEN n.outcome_factor > 0 THEN 1 ELSE 0 END AS numerical_success
      FROM habit_streaks AS s
      INNER JOIN habit_definitions AS h ON h.id = s.habit_id
      LEFT JOIN latest_logs AS l
        ON l.habit_id = s.habit_id
        AND l.position = 1
      LEFT JOIN numerical_habit_entries AS n
        ON n.habit_id = s.habit_id
        AND n.local_day = l.local_day
      WHERE h.deleted_at IS NULL
      ORDER BY s.created_at, l.local_day
      ''',
      readsFrom: {
        database.habitStreaks,
        database.habitDefinitions,
        database.habitLogEntries,
        database.numericalHabitEntries,
      },
    );
    return query.watch().map(_mapRows);
  }

  List<HabitStreakData> _mapRows(List<QueryRow> rows) {
    final grouped = <String, List<QueryRow>>{};
    for (final row in rows) {
      grouped.putIfAbsent(row.read<String>('habit_id'), () => []).add(row);
    }
    return [for (final group in grouped.values) _mapStreak(group)];
  }

  HabitStreakData _mapStreak(List<QueryRow> rows) {
    final first = rows.first;
    final category = first.read<String>('category');
    final createdAt = first.read<DateTime>('created_at');
    final createdDay = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final unwanted = category == 'reduction' || category == 'custom_bad';
    final results = <DateTime, bool>{};
    for (final row in rows) {
      final storedDay = row.readNullable<DateTime>('local_day');
      if (storedDay == null) continue;
      final day = DateTime(storedDay.year, storedDay.month, storedDay.day);
      if (day.isBefore(createdDay)) continue;
      final hasNumerical = row.read<int>('has_numerical') == 1;
      results[day] = hasNumerical
          ? row.read<int>('numerical_success') == 1
          : unwanted
          ? row.read<int>('habit_quantity') == 0
          : row.read<int>('habit_quantity') > 0;
    }
    return HabitStreakData(
      habitId: first.read<String>('habit_id'),
      habitNameKey: first.read<String>('name_key'),
      category: category,
      createdAt: createdAt,
      colorValue: first.readNullable<int>('color_value'),
      dayResults: results,
    );
  }

  @override
  Future<List<HabitStreakHabit>> loadAvailableHabits() async {
    final query = database.select(database.habitDefinitions)
      ..where((habit) => habit.isActive.equals(true) & habit.deletedAt.isNull())
      ..orderBy([(habit) => OrderingTerm.asc(habit.nameKey)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        HabitStreakHabit(
          id: row.id,
          nameKey: row.nameKey,
          category: row.category,
        ),
    ];
  }

  @override
  Future<void> createStreak(String habitId, {int? colorValue}) async {
    final now = DateTime.now();
    await database
        .into(database.habitStreaks)
        .insert(
          HabitStreaksCompanion.insert(
            habitId: habitId,
            colorValue: Value(colorValue),
            createdAt: now,
            updatedAt: now,
          ),
        );
  }

  @override
  Future<void> updateColor(String habitId, int? colorValue) {
    return (database.update(
      database.habitStreaks,
    )..where((row) => row.habitId.equals(habitId))).write(
      HabitStreaksCompanion(
        colorValue: Value(colorValue),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> deleteStreak(String habitId) {
    return (database.delete(
      database.habitStreaks,
    )..where((row) => row.habitId.equals(habitId))).go();
  }
}
