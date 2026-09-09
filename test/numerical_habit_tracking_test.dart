import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

void main() {
  late AppDatabase database;
  late DriftHabitRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftHabitRepository(database);
    await repository.initialize();
  });

  tearDown(() => database.close());

  test('water value replaces the earlier value and is stored once', () async {
    await repository.setHabitNumericalTracking(
      'water',
      enabled: true,
      target: 8,
    );
    await repository.recordNumericalHabit('water', 8);
    var body = await repository.loadBodyState();
    expect(body.parts[BodyPartKey.kidneys]?.score, 4.5);

    await repository.recordNumericalHabit('water', 0);
    body = await repository.loadBodyState();
    expect(body.parts[BodyPartKey.kidneys]?.score, 1.5);

    await repository.recordNumericalHabit('water', 7);
    body = await repository.loadBodyState();
    expect(body.parts[BodyPartKey.kidneys]?.score, 4.5);
    expect(
      await database.select(database.numericalHabitEntries).get(),
      hasLength(1),
    );
    final stored = await repository
        .watchNumericalHabitValues(DateTime.now())
        .first;
    expect(stored.single.value, 7);
    expect(stored.single.outcomeFactor, 1);
  });

  test(
    'positive duration distinguishes zero, near zero, and progress',
    () async {
      await repository.setHabitNumericalTracking(
        'studying',
        enabled: true,
        target: 30,
      );
      await repository.recordNumericalHabit('studying', 0);
      expect(
        (await repository.loadBodyState()).parts[BodyPartKey.brain]?.score,
        2.5,
      );

      await repository.recordNumericalHabit('studying', 5);
      expect(
        (await repository.loadBodyState()).parts[BodyPartKey.brain]?.score,
        3,
      );

      await repository.recordNumericalHabit('studying', 10);
      expect(
        (await repository.loadBodyState()).parts[BodyPartKey.brain]?.score,
        closeTo(3.4, .0001),
      );
    },
  );

  test(
    'occurrence scoring scales harm and thumbs replace the number',
    () async {
      await repository.setHabitNumericalTracking(
        'smoking',
        enabled: true,
        target: 10,
      );
      await repository.recordNumericalHabit('smoking', 1);
      expect(
        (await repository.loadBodyState()).parts[BodyPartKey.lungs]?.score,
        closeTo(2.85, .0001),
      );

      await repository.recordNumericalHabit('smoking', 10);
      expect(
        (await repository.loadBodyState()).parts[BodyPartKey.lungs]?.score,
        1.5,
      );

      await repository.recordHabit('Smoking', didHabit: false);
      expect(
        (await repository.loadBodyState()).parts[BodyPartKey.lungs]?.score,
        4,
      );
      final stored = await repository
          .watchNumericalHabitValues(DateTime.now())
          .first;
      expect(stored.single.value, isNull);
      expect(stored.single.outcomeFactor, 1);
    },
  );

  test('workout duration changes its matching muscle symbolically', () async {
    await repository.setHabitNumericalTracking(
      'workout_legs',
      enabled: true,
      target: 30,
    );
    await repository.recordNumericalHabit('workout_legs', 30);
    expect(
      (await repository.loadBodyState()).parts[BodyPartKey.legs]?.score,
      2,
    );
    await repository.recordNumericalHabit('workout_legs', 0);
    expect(
      (await repository.loadBodyState()).parts[BodyPartKey.legs]?.score,
      1,
    );
  });

  test(
    'single graph uses numerical values and thumb fallback values',
    () async {
      final graphs = DriftCustomGraphRepository(database);
      await graphs.saveSpecialHabit(
        slot: 0,
        habitId: 'water',
        completedValue: 4,
        missedValue: -3,
      );
      await repository.setHabitNumericalTracking(
        'water',
        enabled: true,
        target: 8,
      );
      await repository.recordNumericalHabit('water', 7);
      var graph = (await graphs.watchSpecialHabitGraphs().first).single;
      expect(graph.unitKey, 'glasses');
      expect(graph.days.last.count, 7);

      await repository.recordHabit('water', didHabit: false);
      graph = (await graphs.watchSpecialHabitGraphs().first).single;
      expect(graph.days.last.count, -3);
    },
  );

  test('single graph can load an older seven-day history window', () async {
    final graphs = DriftCustomGraphRepository(database);
    await graphs.saveSpecialHabit(
      slot: 0,
      habitId: 'water',
      completedValue: 2,
      missedValue: -2,
    );
    await repository.setHabitNumericalTracking(
      'water',
      enabled: true,
      target: 8,
    );
    final now = DateTime.now();
    final olderDay = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 10));
    await repository.recordNumericalHabit('water', 6, occurredAt: olderDay);

    final oldGraph =
        (await graphs.watchSpecialHabitGraphs(endingOn: olderDay).first).single;
    expect(oldGraph.days.last.day, olderDay);
    expect(oldGraph.days.last.count, 6);

    final currentGraph = (await graphs.watchSpecialHabitGraphs().first).single;
    expect(currentGraph.days.every((day) => day.count == 0), isTrue);

    final weeklyHistory =
        (await graphs.watchSpecialHabitGraphs(dayCount: 49).first).single;
    expect(weeklyHistory.days, hasLength(49));
    expect(
      weeklyHistory.days.singleWhere((day) => day.day == olderDay).count,
      6,
    );
  });

  test('settings and today value survive a database reopen', () async {
    await database.close();
    final directory = await Directory.systemTemp.createTemp(
      'visualyou_numerical_',
    );
    final file = File(
      '${directory.path}${Platform.pathSeparator}habits.sqlite',
    );
    database = AppDatabase(NativeDatabase(file));
    repository = DriftHabitRepository(database);
    await repository.initialize();
    await repository.setHabitNumericalTracking(
      'water',
      enabled: true,
      target: 9,
    );
    await repository.recordNumericalHabit('water', 9);
    await database.close();

    database = AppDatabase(NativeDatabase(file));
    repository = DriftHabitRepository(database);
    await repository.initialize();
    final preference = (await repository.watchHabitPreferences().first)
        .singleWhere((habit) => habit.id == 'water');
    final value =
        (await repository.watchNumericalHabitValues(DateTime.now()).first)
            .single;
    expect(preference.numericalTrackingEnabled, isTrue);
    expect(preference.numericalTarget, 9);
    expect(value.value, 9);
    await database.close();
    await directory.delete(recursive: true);
    database = AppDatabase(NativeDatabase.memory());
  });

  test('Free is locked, Plus allows four, and Pro is unlimited', () async {
    final rewards = RewardsRepository(database);
    await rewards.initialize();

    await expectLater(
      repository.setHabitNumericalTracking('water', enabled: true, target: 8),
      throwsStateError,
    );

    await rewards.setPlan(MembershipPlan.plus);
    for (final setting in const [
      ('water', 8),
      ('smoking', 10),
      ('vaping', 10),
      ('alcohol', 3),
    ]) {
      await repository.setHabitNumericalTracking(
        setting.$1,
        enabled: true,
        target: setting.$2,
      );
    }
    await expectLater(
      repository.setHabitNumericalTracking(
        'masturbation',
        enabled: true,
        target: 2,
      ),
      throwsStateError,
    );

    await rewards.setPlan(MembershipPlan.pro);
    await repository.setHabitNumericalTracking(
      'masturbation',
      enabled: true,
      target: 2,
    );
    final enabled = (await repository.watchHabitPreferences().first).where(
      (habit) => habit.numericalTrackingEnabled,
    );
    expect(enabled, hasLength(5));
  });

  test(
    'custom habits support persisted time-based numerical tracking',
    () async {
      final rewards = RewardsRepository(database);
      await rewards.initialize();
      await rewards.setPlan(MembershipPlan.pro);
      final habitId = await repository.createCustomHabit(
        name: 'Practice piano',
        isUnwanted: false,
      );

      await repository.setHabitNumericalTracking(
        habitId,
        enabled: true,
        target: 45,
        unitKey: 'minutes',
      );
      await repository.recordNumericalHabit(habitId, 30);

      final preference = (await repository.watchHabitPreferences().first)
          .singleWhere((habit) => habit.id == habitId);
      final value =
          (await repository.watchNumericalHabitValues(DateTime.now()).first)
              .singleWhere((entry) => entry.habitId == habitId);
      expect(preference.numericalTrackingEnabled, isTrue);
      expect(preference.numericalUnit, 'minutes');
      expect(preference.numericalTarget, 45);
      expect(value.value, 30);
    },
  );
}
