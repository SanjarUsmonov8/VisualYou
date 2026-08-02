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

  const effects = <String, Map<String, int>>{
    'Smoking': {
      BodyPartKey.lungs: -3,
      BodyPartKey.heart: -2,
      BodyPartKey.brain: -1,
      BodyPartKey.liver: -1,
      BodyPartKey.stomach: -1,
      BodyPartKey.kidneys: -1,
      BodyPartKey.gut: -1,
    },
    'Vaping': {
      BodyPartKey.lungs: -3,
      BodyPartKey.heart: -2,
      BodyPartKey.brain: -1,
      BodyPartKey.gut: -1,
      BodyPartKey.stomach: -1,
    },
    'Alcohol': {
      BodyPartKey.liver: -3,
      BodyPartKey.brain: -2,
      BodyPartKey.heart: -2,
      BodyPartKey.stomach: -2,
      BodyPartKey.gut: -2,
      BodyPartKey.kidneys: -1,
    },
    'Unhealthy eating': {
      BodyPartKey.gut: -3,
      BodyPartKey.heart: -2,
      BodyPartKey.liver: -2,
      BodyPartKey.brain: -1,
      BodyPartKey.stomach: -1,
      BodyPartKey.kidneys: -1,
    },
    'Consuming sugar': {
      BodyPartKey.liver: -3,
      BodyPartKey.gut: -2,
      BodyPartKey.heart: -1,
      BodyPartKey.brain: -1,
      BodyPartKey.kidneys: -1,
      BodyPartKey.stomach: -1,
    },
    'Adult videos': {BodyPartKey.brain: -3},
    'Masturbation': {BodyPartKey.brain: -3},
    'Drinking water': {
      BodyPartKey.kidneys: 3,
      BodyPartKey.gut: 2,
      BodyPartKey.brain: 2,
      BodyPartKey.heart: 2,
      BodyPartKey.stomach: 1,
      BodyPartKey.liver: 1,
      BodyPartKey.lungs: 1,
    },
    'Eating healthy': {
      BodyPartKey.gut: 3,
      BodyPartKey.brain: 2,
      BodyPartKey.heart: 2,
      BodyPartKey.liver: 2,
      BodyPartKey.stomach: 2,
      BodyPartKey.kidneys: 2,
      BodyPartKey.lungs: 1,
    },
  };

  const notDoneEffects = <String, Map<String, int>>{
    'Smoking': {
      BodyPartKey.lungs: 3,
      BodyPartKey.heart: 2,
      BodyPartKey.brain: 1,
      BodyPartKey.liver: 1,
      BodyPartKey.stomach: 1,
      BodyPartKey.kidneys: 1,
      BodyPartKey.gut: 1,
    },
    'Vaping': {
      BodyPartKey.lungs: 3,
      BodyPartKey.heart: 2,
      BodyPartKey.brain: 1,
      BodyPartKey.gut: 1,
      BodyPartKey.stomach: 1,
    },
    'Alcohol': {
      BodyPartKey.liver: 3,
      BodyPartKey.brain: 2,
      BodyPartKey.stomach: 2,
      BodyPartKey.gut: 2,
      BodyPartKey.heart: 2,
      BodyPartKey.kidneys: 1,
    },
    'Unhealthy eating': {
      BodyPartKey.gut: 3,
      BodyPartKey.heart: 2,
      BodyPartKey.liver: 2,
      BodyPartKey.brain: 1,
      BodyPartKey.stomach: 1,
      BodyPartKey.kidneys: 1,
    },
    'Consuming sugar': {
      BodyPartKey.liver: 3,
      BodyPartKey.gut: 2,
      BodyPartKey.brain: 2,
      BodyPartKey.heart: 1,
      BodyPartKey.kidneys: 1,
      BodyPartKey.stomach: 1,
    },
    'Adult videos': {BodyPartKey.brain: 3},
    'Masturbation': {BodyPartKey.brain: 3},
    'Drinking water': {
      BodyPartKey.kidneys: -3,
      BodyPartKey.gut: -2,
      BodyPartKey.brain: -2,
      BodyPartKey.heart: -2,
      BodyPartKey.stomach: -1,
      BodyPartKey.liver: -1,
      BodyPartKey.lungs: -1,
    },
    'Eating healthy': {
      BodyPartKey.gut: -3,
      BodyPartKey.brain: -2,
      BodyPartKey.heart: -2,
      BodyPartKey.liver: -2,
      BodyPartKey.stomach: -2,
      BodyPartKey.kidneys: -2,
      BodyPartKey.lungs: -1,
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
          final expectedLevel = (3 + points).clamp(1, 5);
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
          final expectedLevel = (3 + points).clamp(1, 5);
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
