import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_models.dart';
import 'package:visualyou/features/numerical_heatmap/numerical_heatmap_repository.dart';

void main() {
  test('numerical heatmap stores its habit and reads daily performance', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final habits = DriftHabitRepository(database);
    await habits.initialize();
    await habits.setHabitNumericalTracking(
      'water',
      enabled: true,
      target: 8,
    );
    await habits.recordNumericalHabit('water', 8);

    final heatmaps = DriftNumericalHeatmapRepository(database);
    await heatmaps.createHeatmap(
      slot: 0,
      setup: const NumericalHeatmapSetup(
        habitId: 'water',
        higherIsBetter: true,
        orangeThreshold: 2,
        yellowThreshold: 4,
        greenThreshold: 6,
        blueThreshold: 8,
      ),
    );
    final stored = (await heatmaps.watchHeatmaps().first).single;
    final now = DateTime.now();

    expect(stored.habitId, 'water');
    expect(stored.blueThreshold, 8);
    expect(stored.valueByDay.values.single, 8);
    expect(
      stored.outcomeByDay[DateTime(now.year, now.month, now.day)],
      1,
    );

    await heatmaps.deleteHeatmap(0);
    expect(await heatmaps.watchHeatmaps().first, isEmpty);
  });
}
