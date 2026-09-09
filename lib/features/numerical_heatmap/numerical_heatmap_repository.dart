import 'dart:async';

import 'package:drift/drift.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_models.dart';

abstract interface class NumericalHeatmapRepository {
  Stream<List<NumericalHeatmapData>> watchHeatmaps();

  Future<List<NumericalHeatmapHabit>> loadAvailableHabits();

  Future<void> createHeatmap({
    required int slot,
    required NumericalHeatmapSetup setup,
  });

  Future<void> deleteHeatmap(int slot);
}

class DriftNumericalHeatmapRepository implements NumericalHeatmapRepository {
  DriftNumericalHeatmapRepository(this.database);

  final AppDatabase database;
  final StreamController<void> _changes = StreamController<void>.broadcast();

  @override
  Stream<List<NumericalHeatmapData>> watchHeatmaps() {
    late StreamController<List<NumericalHeatmapData>> controller;
    StreamSubscription<dynamic>? databaseSubscription;
    StreamSubscription<void>? changeSubscription;

    Future<void> emit() async {
      if (!controller.isClosed) controller.add(await _loadHeatmaps());
    }

    controller = StreamController<List<NumericalHeatmapData>>(
      onListen: () {
        databaseSubscription = database
            .select(database.numericalHabitEntries)
            .watch()
            .listen((_) => emit());
        changeSubscription = _changes.stream.listen((_) => emit());
        emit();
      },
      onCancel: () async {
        await databaseSubscription?.cancel();
        await changeSubscription?.cancel();
      },
    );
    return controller.stream;
  }

  Future<List<NumericalHeatmapData>> _loadHeatmaps() async {
    final query = database.customSelect(
      '''
      SELECT
        m.slot,
        m.habit_id,
        m.created_at,
        h.name_key,
        h.numerical_unit,
        m.higher_is_better,
        m.orange_threshold,
        m.yellow_threshold,
        m.green_threshold,
        m.blue_threshold,
        n.local_day,
        n.value AS numerical_value,
        n.outcome_factor
      FROM numerical_habit_heatmaps AS m
      INNER JOIN habit_definitions AS h ON h.id = m.habit_id
      LEFT JOIN numerical_habit_entries AS n ON n.habit_id = m.habit_id
      WHERE h.deleted_at IS NULL
        AND h.is_active = 1
        AND h.numerical_tracking_enabled = 1
      ORDER BY m.slot, n.local_day
      ''',
      readsFrom: {
        database.habitDefinitions,
        database.numericalHabitEntries,
      },
    );
    return _mapRows(await query.get());
  }

  List<NumericalHeatmapData> _mapRows(List<QueryRow> rows) {
    final grouped = <int, List<QueryRow>>{};
    for (final row in rows) {
      grouped.putIfAbsent(row.read<int>('slot'), () => []).add(row);
    }
    return [for (final rows in grouped.values) _mapHeatmap(rows)];
  }

  NumericalHeatmapData _mapHeatmap(List<QueryRow> rows) {
    final first = rows.first;
    final outcomes = <DateTime, double>{};
    final values = <DateTime, int?>{};
    for (final row in rows) {
      final storedDay = row.readNullable<DateTime>('local_day');
      if (storedDay == null) continue;
      final day = DateTime(storedDay.year, storedDay.month, storedDay.day);
      outcomes[day] = row.read<double>('outcome_factor');
      values[day] = row.readNullable<int>('numerical_value');
    }
    return NumericalHeatmapData(
      slot: first.read<int>('slot'),
      habitId: first.read<String>('habit_id'),
      habitNameKey: first.read<String>('name_key'),
      unitKey: first.readNullable<String>('numerical_unit'),
      higherIsBetter: first.read<int>('higher_is_better') == 1,
      orangeThreshold: first.read<int>('orange_threshold'),
      yellowThreshold: first.read<int>('yellow_threshold'),
      greenThreshold: first.read<int>('green_threshold'),
      blueThreshold: first.read<int>('blue_threshold'),
      createdAt: first.read<DateTime>('created_at'),
      outcomeByDay: outcomes,
      valueByDay: values,
    );
  }

  @override
  Future<List<NumericalHeatmapHabit>> loadAvailableHabits() async {
    final query = database.select(database.habitDefinitions)
      ..where(
        (habit) =>
            habit.isActive.equals(true) &
            habit.deletedAt.isNull() &
            habit.numericalTrackingEnabled.equals(true),
      )
      ..orderBy([(habit) => OrderingTerm.asc(habit.nameKey)]);
    final rows = await query.get();
    return [
      for (final row in rows)
        NumericalHeatmapHabit(
          id: row.id,
          nameKey: row.nameKey,
          unitKey: row.numericalUnit ?? 'times',
          target: row.numericalTarget ?? 1,
        ),
    ];
  }

  @override
  Future<void> createHeatmap({
    required int slot,
    required NumericalHeatmapSetup setup,
  }) {
    final now = DateTime.now();
    return database.customInsert(
      '''
      INSERT INTO numerical_habit_heatmaps
        (slot, habit_id, higher_is_better, orange_threshold,
         yellow_threshold, green_threshold, blue_threshold, created_at, updated_at)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
      ''',
      variables: [
        Variable<int>(slot),
        Variable<String>(setup.habitId),
        Variable<int>(setup.higherIsBetter ? 1 : 0),
        Variable<int>(setup.orangeThreshold),
        Variable<int>(setup.yellowThreshold),
        Variable<int>(setup.greenThreshold),
        Variable<int>(setup.blueThreshold),
        Variable<DateTime>(now),
        Variable<DateTime>(now),
      ],
    ).then((_) => _changes.add(null));
  }

  @override
  Future<void> deleteHeatmap(int slot) {
    return database.customUpdate(
      'DELETE FROM numerical_habit_heatmaps WHERE slot = ?',
      variables: [Variable<int>(slot)],
    ).then((_) => _changes.add(null));
  }
}
