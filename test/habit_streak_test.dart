import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/habit_streak/habit_streak_models.dart';
import 'package:visualyou/features/habit_streak/habit_streak_repository.dart';
import 'package:visualyou/features/habit_streak/habit_streak_section.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

void main() {
  test('a habit streak counts consecutive successful days only', () {
    final today = DateTime(2026, 9, 4);
    HabitStreakData streak(Map<DateTime, bool> results) => HabitStreakData(
      habitId: 'water',
      habitNameKey: 'Drinking water',
      category: 'good',
      createdAt: DateTime(2026, 9, 1),
      dayResults: results,
    );

    expect(
      streak({
        DateTime(2026, 9, 2): true,
        DateTime(2026, 9, 3): true,
        today: true,
      }).currentStreak(now: today),
      3,
    );
    expect(
      streak({DateTime(2026, 9, 3): true}).currentStreak(now: today),
      1,
    );
    expect(
      streak({DateTime(2026, 9, 3): true, today: false})
          .currentStreak(now: today),
      0,
    );
  });

  test('repository stores streaks and follows the latest daily answer', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final habits = DriftHabitRepository(database);
    await habits.initialize();
    final streaks = DriftHabitStreakRepository(database);

    await streaks.createStreak('water', colorValue: 0xFF1E88E5);
    await habits.recordHabit('water', didHabit: true);
    var saved = (await streaks.watchStreaks().first).single;
    expect(saved.colorValue, 0xFF1E88E5);
    expect(saved.successfulDays, contains(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    )));

    await habits.recordHabit('water', didHabit: false);
    saved = (await streaks.watchStreaks().first).single;
    expect(saved.dayResults.values.single, isFalse);
  });

  test('avoiding an unwanted habit counts as its successful day', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final habits = DriftHabitRepository(database);
    await habits.initialize();
    final streaks = DriftHabitStreakRepository(database);

    await streaks.createStreak('smoking');
    await habits.recordHabit('smoking', didHabit: false);
    final saved = (await streaks.watchStreaks().first).single;
    expect(saved.dayResults.values.single, isTrue);
  });

  testWidgets('tapping a day asks and records an unwanted habit answer', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final habits = DriftHabitRepository(database);
    await habits.initialize();
    final streaks = DriftHabitStreakRepository(database);
    await streaks.createStreak('smoking');
    final rewards = RewardsController(RewardsRepository(database));
    await rewards.initialize();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: HabitStreakSection(
              repository: streaks,
              habitRepository: habits,
              rewardsController: rewards,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('${DateTime.now().day}'));
    await tester.pumpAndSettle();
    expect(find.text('Did you do this habit?'), findsOneWidget);

    await tester.tap(find.text('I did not'));
    await tester.pumpAndSettle();
    final saved = (await streaks.watchStreaks().first).single;
    expect(saved.dayResults.values.single, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
    rewards.dispose();
    await database.close();
    await tester.pump(const Duration(milliseconds: 1));
  });
}
