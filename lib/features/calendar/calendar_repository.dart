import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/calendar/calendar_models.dart';

abstract interface class CalendarRepository {
  Stream<List<CalendarDaySummary>> watchMonth(DateTime month);
}

class DriftCalendarRepository implements CalendarRepository {
  DriftCalendarRepository(this.database);

  final AppDatabase database;

  @override
  Stream<List<CalendarDaySummary>> watchMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month);
    final nextMonth = DateTime(month.year, month.month + 1);
    final query = database.customSelect(
      '''
      SELECT
        l.local_day,
        l.habit_id,
        h.name_key,
        h.category,
        SUM(l.quantity) AS habit_count
      FROM habit_log_entries AS l
      INNER JOIN habit_definitions AS h ON h.id = l.habit_id
      WHERE l.deleted_at IS NULL
        AND h.deleted_at IS NULL
        AND l.local_day >= ?
        AND l.local_day < ?
      GROUP BY l.local_day, l.habit_id, h.name_key, h.category
      ORDER BY l.local_day, h.name_key
      ''',
      variables: [Variable(firstDay), Variable(nextMonth)],
      readsFrom: {database.habitLogEntries, database.habitDefinitions},
    );
    return query.watch().map(_summariesFromRows);
  }

  static List<CalendarDaySummary> _summariesFromRows(List<QueryRow> rows) {
    final activitiesByDay = <DateTime, List<CalendarActivity>>{};
    for (final row in rows) {
      final storedDay = row.read<DateTime>('local_day');
      final day = DateTime(storedDay.year, storedDay.month, storedDay.day);
      activitiesByDay
          .putIfAbsent(day, () => [])
          .add(
            CalendarActivity(
              habitId: row.read<String>('habit_id'),
              habitNameKey: row.read<String>('name_key'),
              category: row.read<String>('category'),
              count: row.read<int>('habit_count'),
            ),
          );
    }
    return [
      for (final entry in activitiesByDay.entries)
        CalendarDaySummary(day: entry.key, activities: entry.value),
    ]..sort((first, second) => first.day.compareTo(second.day));
  }
}
