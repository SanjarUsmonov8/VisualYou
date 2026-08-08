import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';

void main() {
  const organs = [
    BodyPartKey.brain,
    BodyPartKey.lungs,
    BodyPartKey.heart,
    BodyPartKey.liver,
    BodyPartKey.stomach,
    BodyPartKey.kidneys,
    BodyPartKey.gut,
  ];

  const effects = <String, Map<String, double>>{
    'Smoking': {
      BodyPartKey.lungs: -1.5,
      BodyPartKey.heart: -1,
      BodyPartKey.brain: -.5,
      BodyPartKey.liver: -.5,
      BodyPartKey.stomach: -.5,
      BodyPartKey.kidneys: -.5,
      BodyPartKey.gut: -.5,
    },
    'Vaping': {
      BodyPartKey.lungs: -1.5,
      BodyPartKey.heart: -1,
      BodyPartKey.brain: -.5,
      BodyPartKey.gut: -.5,
      BodyPartKey.stomach: -.5,
    },
    'Alcohol': {
      BodyPartKey.liver: -1.5,
      BodyPartKey.brain: -1,
      BodyPartKey.heart: -1,
      BodyPartKey.stomach: -1,
      BodyPartKey.gut: -1,
      BodyPartKey.kidneys: -.5,
    },
    'Unhealthy eating': {
      BodyPartKey.gut: -1.5,
      BodyPartKey.heart: -1,
      BodyPartKey.liver: -1,
      BodyPartKey.brain: -.5,
      BodyPartKey.stomach: -.5,
      BodyPartKey.kidneys: -.5,
    },
    'Consuming sugar': {
      BodyPartKey.liver: -1.5,
      BodyPartKey.gut: -1,
      BodyPartKey.heart: -.5,
      BodyPartKey.brain: -.5,
      BodyPartKey.kidneys: -.5,
      BodyPartKey.stomach: -.5,
    },
    'Adult videos': {BodyPartKey.brain: -1.5},
    'Masturbation': {BodyPartKey.brain: -1.5},
    'Drinking water': {
      BodyPartKey.kidneys: 1.5,
      BodyPartKey.gut: 1,
      BodyPartKey.brain: 1,
      BodyPartKey.heart: 1,
      BodyPartKey.stomach: .5,
      BodyPartKey.liver: .5,
      BodyPartKey.lungs: .5,
    },
    'Eating healthy': {
      BodyPartKey.gut: 1.5,
      BodyPartKey.brain: 1,
      BodyPartKey.heart: 1,
      BodyPartKey.liver: 1,
      BodyPartKey.stomach: 1,
      BodyPartKey.kidneys: 1,
      BodyPartKey.lungs: .5,
    },
  };

  const notDoneEffects = <String, Map<String, double>>{
    'Smoking': {
      BodyPartKey.lungs: 1,
      BodyPartKey.heart: .5,
      BodyPartKey.brain: .25,
      BodyPartKey.liver: .25,
      BodyPartKey.stomach: .25,
      BodyPartKey.kidneys: .25,
      BodyPartKey.gut: .25,
    },
    'Vaping': {
      BodyPartKey.lungs: 1,
      BodyPartKey.heart: .5,
      BodyPartKey.brain: .25,
      BodyPartKey.gut: .25,
      BodyPartKey.stomach: .25,
    },
    'Alcohol': {
      BodyPartKey.liver: 1,
      BodyPartKey.brain: .5,
      BodyPartKey.stomach: .5,
      BodyPartKey.gut: .5,
      BodyPartKey.heart: .5,
      BodyPartKey.kidneys: .25,
    },
    'Unhealthy eating': {
      BodyPartKey.gut: 1,
      BodyPartKey.heart: .5,
      BodyPartKey.liver: .5,
      BodyPartKey.brain: .25,
      BodyPartKey.stomach: .25,
      BodyPartKey.kidneys: .25,
    },
    'Consuming sugar': {
      BodyPartKey.liver: 1,
      BodyPartKey.gut: .5,
      BodyPartKey.brain: .5,
      BodyPartKey.heart: .25,
      BodyPartKey.kidneys: .25,
      BodyPartKey.stomach: .25,
    },
    'Adult videos': {BodyPartKey.brain: 1},
    'Masturbation': {BodyPartKey.brain: 1},
    'Drinking water': {
      BodyPartKey.kidneys: -1.5,
      BodyPartKey.gut: -1,
      BodyPartKey.brain: -1,
      BodyPartKey.heart: -1,
      BodyPartKey.stomach: -.5,
      BodyPartKey.liver: -.5,
      BodyPartKey.lungs: -.5,
    },
    'Eating healthy': {
      BodyPartKey.gut: -1.25,
      BodyPartKey.brain: -.75,
      BodyPartKey.heart: -.75,
      BodyPartKey.liver: -.75,
      BodyPartKey.stomach: -.75,
      BodyPartKey.kidneys: -.75,
      BodyPartKey.lungs: -.5,
    },
  };

  test('organs start at OK level without a visible tint', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftHabitRepository(database);
    await repository.initialize();

    final state = await repository.loadBodyState();
    for (final organ in organs) {
      expect(state.parts[organ]?.level, 3, reason: organ);
      expect(state.parts[organ]?.score, 3.0, reason: organ);
      expect(state.parts[organ]?.colorValue, isNull, reason: organ);
    }
  });

  for (final habit in effects.entries) {
    test('${habit.key} applies its organ point table', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftHabitRepository(database);
      try {
        await repository.initialize();
        await repository.recordHabit(habit.key);
        final state = await repository.loadBodyState();

        for (final organ in organs) {
          final points = habit.value[organ] ?? 0;
          final expectedScore = (3.0 + points).clamp(1.0, 5.0);
          final expectedLevel = expectedScore.round().clamp(1, 5);
          expect(state.parts[organ]?.score, expectedScore, reason: organ);
          expect(state.parts[organ]?.level, expectedLevel, reason: organ);
          expect(
            state.parts[organ]?.colorValue,
            points == 0 ? isNull : _colorFor(expectedLevel),
            reason: organ,
          );
        }
      } finally {
        await database.close();
      }
    });
  }

  for (final habit in notDoneEffects.entries) {
    test('${habit.key} alternative outcome applies its point table', () async {
      final database = AppDatabase(NativeDatabase.memory());
      final repository = DriftHabitRepository(database);
      try {
        await repository.initialize();
        await repository.recordHabit(habit.key, didHabit: false);
        final logs = await database.select(database.habitLogEntries).get();
        expect(logs.single.quantity, 0);
        final state = await repository.loadBodyState();

        for (final organ in organs) {
          final points = habit.value[organ] ?? 0;
          final expectedScore = (3.0 + points).clamp(1.0, 5.0);
          final expectedLevel = expectedScore.round().clamp(1, 5);
          expect(state.parts[organ]?.score, expectedScore, reason: organ);
          expect(state.parts[organ]?.level, expectedLevel, reason: organ);
          expect(
            state.parts[organ]?.colorValue,
            points == 0 ? isNull : _colorFor(expectedLevel),
            reason: organ,
          );
        }
      } finally {
        await database.close();
      }
    });
  }

  test('missing a workout lowers only its muscle by one', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftHabitRepository(database);
    await repository.initialize();

    await repository.recordHabit('Arm');
    await repository.recordHabit('Arm');
    await repository.recordHabit('Arm', didHabit: false);
    var state = await repository.loadBodyState();
    expect(state.parts[BodyPartKey.arms]?.level, 1);
    expect(state.parts[BodyPartKey.arms]?.colorValue, 0xFFE53935);

    await repository.recordHabit('Legs', didHabit: false);
    state = await repository.loadBodyState();
    expect(state.parts[BodyPartKey.legs]?.level, 1);
    expect(state.parts[BodyPartKey.legs]?.colorValue, 0xFFE53935);
  });

  test('overnight recovery is applied once for each elapsed day', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftHabitRepository(database);
    await repository.initialize();

    final yesterday = DateTime(2026, 8, 3);
    await database
        .into(database.appSettings)
        .insertOnConflictUpdate(
          AppSettingsCompanion.insert(
            key: 'last_organ_recovery_day',
            value:
                '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}',
            updatedAt: yesterday,
          ),
        );

    var state = await repository.applyDailyRecovery(now: DateTime(2026, 8, 4));
    expect(state.parts[BodyPartKey.brain]?.score, 3.5);
    expect(state.parts[BodyPartKey.brain]?.level, 4);
    expect(state.parts[BodyPartKey.heart]?.score, 3.5);
    expect(state.parts[BodyPartKey.lungs]?.score, 3.25);
    expect(state.parts[BodyPartKey.lungs]?.level, 3);
    expect(state.parts[BodyPartKey.liver]?.score, 3.5);
    expect(state.parts[BodyPartKey.kidneys]?.score, 3.5);
    expect(state.parts[BodyPartKey.gut]?.score, 3.5);
    expect(state.parts[BodyPartKey.stomach]?.score, 3.25);

    state = await repository.applyDailyRecovery(now: DateTime(2026, 8, 4));
    expect(state.parts[BodyPartKey.brain]?.score, 3.5);
    expect(state.parts[BodyPartKey.lungs]?.score, 3.25);
  });
}

int _colorFor(int level) {
  return switch (level) {
    <= 1 => 0xFFE53935,
    2 => 0xFFFB8C00,
    3 => 0xFFFFCA28,
    4 => 0xFF43A047,
    _ => 0xFF1E88E5,
  };
}
