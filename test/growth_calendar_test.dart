import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/growth_calendar/growth_calendar_models.dart';
import 'package:visualyou/features/growth_calendar/growth_calendar_repository.dart';

void main() {
  GrowthCalendarData plan({
    required GrowthMode mode,
    int days = 3,
    int repetitions = 2,
    Set<int> offDays = const {DateTime.saturday, DateTime.sunday},
    Map<int, int> weekdayRepetitions = const {},
  }) => GrowthCalendarData(
    planId: 'growth-1',
    habitId: 'workout',
    habitNameKey: 'Workout',
    mode: mode,
    startedOn: DateTime(2026, 9, 7), // Monday.
    targetDaysPerWeek: days,
    targetRepetitionsPerDay: repetitions,
    offWeekdays: offDays,
    weekdayRepetitions: weekdayRepetitions,
    completedCounts: const {},
  );

  test('fast mode grows weekly frequency then daily repetitions', () {
    final value = plan(mode: GrowthMode.fast);

    expect(value.targetOn(DateTime(2026, 9, 9)).weeklyFrequency, 1);
    expect(value.targetOn(DateTime(2026, 9, 14)).weeklyFrequency, 2);
    expect(value.targetOn(DateTime(2026, 9, 21)).weeklyFrequency, 3);
    expect(value.targetOn(DateTime(2026, 9, 21)).repetitions, 1);
    expect(value.targetOn(DateTime(2026, 9, 28)).repetitions, 2);
  });

  test('three target days spread across Monday Wednesday Friday', () {
    final value = plan(mode: GrowthMode.fast);
    final thirdWeek = DateTime(2026, 9, 21);

    expect(value.targetOn(thirdWeek).scheduled, isTrue);
    expect(
      value.targetOn(thirdWeek.add(const Duration(days: 1))).scheduled,
      isFalse,
    );
    expect(
      value.targetOn(thirdWeek.add(const Duration(days: 2))).scheduled,
      isTrue,
    );
    expect(
      value.targetOn(thirdWeek.add(const Duration(days: 4))).scheduled,
      isTrue,
    );
  });

  test('days off are never scheduled', () {
    final value = plan(
      mode: GrowthMode.fast,
      days: 7,
      offDays: const {DateTime.wednesday, DateTime.sunday},
    );

    for (var week = 0; week < 20; week++) {
      final monday = DateTime(2026, 9, 7).add(Duration(days: week * 7));
      expect(
        value.targetOn(monday.add(const Duration(days: 2))).scheduled,
        isFalse,
      );
      expect(
        value.targetOn(monday.add(const Duration(days: 6))).scheduled,
        isFalse,
      );
    }
  });

  test('medium repeats level n for n weeks', () {
    final value = plan(mode: GrowthMode.medium, days: 3, repetitions: 1);

    expect(value.targetOn(DateTime(2026, 9, 9)).weeklyFrequency, 1);
    expect(value.targetOn(DateTime(2026, 9, 14)).weeklyFrequency, 2);
    expect(value.targetOn(DateTime(2026, 9, 21)).weeklyFrequency, 2);
    expect(value.targetOn(DateTime(2026, 9, 28)).weeklyFrequency, 3);
  });

  test('slow repeats level n for n plus one weeks', () {
    final value = plan(mode: GrowthMode.slow, days: 3, repetitions: 1);

    expect(value.targetOn(DateTime(2026, 9, 9)).weeklyFrequency, 1);
    expect(value.targetOn(DateTime(2026, 9, 14)).weeklyFrequency, 1);
    expect(value.targetOn(DateTime(2026, 9, 21)).weeklyFrequency, 2);
    expect(value.targetOn(DateTime(2026, 10, 5)).weeklyFrequency, 2);
    expect(value.targetOn(DateTime(2026, 10, 12)).weeklyFrequency, 3);
  });

  test('weekday overrides grow toward their own repetition targets', () {
    final value = plan(
      mode: GrowthMode.fast,
      days: 3,
      repetitions: 2,
      weekdayRepetitions: const {DateTime.monday: 4},
    );

    // Weekly frequency reaches three first. Repetitions then rise gradually.
    expect(value.targetOn(DateTime(2026, 9, 28)).repetitions, 2);
    expect(value.targetOn(DateTime(2026, 10, 5)).repetitions, 3);
    expect(value.targetOn(DateTime(2026, 10, 12)).repetitions, 4);
    // Wednesday keeps the general target of two.
    expect(value.targetOn(DateTime(2026, 10, 14)).repetitions, 2);
  });

  test('plans and completed repetition counts persist in SQLite', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await DriftHabitRepository(database).initialize();
    final repository = DriftGrowthCalendarRepository(database);
    final start = DateTime(2026, 9, 7);

    await repository.createPlan(
      habitId: 'water',
      mode: GrowthMode.medium,
      startedOn: start,
      targetDaysPerWeek: 5,
      targetRepetitionsPerDay: 3,
      offWeekdays: const {DateTime.saturday, DateTime.sunday},
      weekdayRepetitions: const {DateTime.monday: 4},
    );
    final created = (await repository.watchPlansMonth(start).first).single;
    await repository.setDayCount(
      planId: created.planId,
      day: start.add(const Duration(days: 2)),
      completedCount: 1,
    );
    final saved = (await repository.watchPlansMonth(start).first).single;

    expect(saved.habitId, 'water');
    expect(saved.mode, GrowthMode.medium);
    expect(saved.targetDaysPerWeek, 5);
    expect(saved.targetRepetitionsPerDay, 3);
    expect(saved.offWeekdays, {DateTime.saturday, DateTime.sunday});
    expect(saved.weekdayRepetitions, {DateTime.monday: 4});
    expect(saved.completedOn(start.add(const Duration(days: 2))), 1);
  });

  test(
    'duration growth plans increase in 15-minute stages and persist',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      await DriftHabitRepository(database).initialize();
      final repository = DriftGrowthCalendarRepository(database);
      final start = DateTime(2026, 9, 7);

      await repository.createPlan(
        habitId: 'reading',
        mode: GrowthMode.fast,
        startedOn: start,
        targetDaysPerWeek: 1,
        targetRepetitionsPerDay: 60,
        offWeekdays: const {
          DateTime.tuesday,
          DateTime.wednesday,
          DateTime.thursday,
          DateTime.friday,
          DateTime.saturday,
          DateTime.sunday,
        },
        measurementUnit: GrowthMeasurementUnit.minutes,
      );

      final saved = (await repository.watchPlansMonth(start).first).single;
      expect(saved.measurementUnit, GrowthMeasurementUnit.minutes);
      expect(saved.targetOn(start).repetitions, 15);
      expect(
        saved.targetOn(start.add(const Duration(days: 7))).repetitions,
        30,
      );
    },
  );
}
