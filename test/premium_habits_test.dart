import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/habits/habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/habit_access.dart';
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

  test(
    'studying and breathing apply only their requested organ points',
    () async {
      var body = await repository.recordHabit('Studying');
      expect(body.parts[BodyPartKey.brain]?.score, 4);
      expect(body.parts[BodyPartKey.lungs]?.score, 3);

      body = await repository.recordHabit('Studying', didHabit: false);
      expect(body.parts[BodyPartKey.brain]?.score, 3.5);

      body = await repository.applyBreathingReward();
      expect(body.parts[BodyPartKey.brain]?.score, 5);
      expect(body.parts[BodyPartKey.lungs]?.score, 4.5);
    },
  );

  test('new Pro habits are seeded inactive in their correct groups', () async {
    const goodIds = {
      'brushing_teeth',
      'skin_care',
      'good_sleep',
      'meditation',
      'reading',
      'consistent_routine',
      'practising_gratitude',
      'productive_work',
    };
    const unwantedIds = {
      'excessive_screen_time',
      'excessive_caffeine',
      'social_media_overuse',
      'nail_biting',
      'gaming_overuse',
    };
    final preferences = await repository.watchHabitPreferences().first;
    final byId = {for (final habit in preferences) habit.id: habit};
    for (final id in goodIds) {
      expect(byId[id]?.category, 'good');
      expect(byId[id]?.isActive, isFalse);
    }
    for (final id in unwantedIds) {
      expect(byId[id]?.category, 'reduction');
      expect(byId[id]?.isActive, isFalse);
    }
  });

  test('new habits use the requested symbolic Mind points', () async {
    const expected = <String, (double, double)>{
      'brushing_teeth': (.25, -.25),
      'skin_care': (.5, -.25),
      'good_sleep': (1, -1),
      'meditation': (1, -.5),
      'reading': (1, 0),
      'consistent_routine': (1, -1),
      'practising_gratitude': (1, 0),
      'productive_work': (.5, 0),
      'excessive_screen_time': (1, -1.5),
      'excessive_caffeine': (.5, -.5),
      'social_media_overuse': (1, -1),
      'nail_biting': (.25, -.25),
      'gaming_overuse': (1, -1.5),
      'healthy_eating': (.5, -.25),
    };
    for (final entry in expected.entries) {
      final settings = await repository.loadStandardHabitOrganEffects(
        entry.key,
      );
      final mind = settings.effects.singleWhere(
        (effect) => effect.partKey == BodyPartKey.brain,
      );
      expect(mind.thumbUpPoints, entry.value.$1, reason: entry.key);
      expect(mind.thumbDownPoints, entry.value.$2, reason: entry.key);
    }
  });

  test('excessive caffeine uses the selected symbolic organ points', () async {
    final settings = await repository.loadStandardHabitOrganEffects(
      'excessive_caffeine',
    );
    final byPart = {
      for (final effect in settings.effects) effect.partKey: effect,
    };
    const expected = <String, (double, double)>{
      BodyPartKey.brain: (.5, -.5),
      BodyPartKey.heart: (.5, -1),
      BodyPartKey.stomach: (.25, -.5),
      BodyPartKey.kidneys: (.25, -.25),
      BodyPartKey.gut: (.25, -.5),
      BodyPartKey.lungs: (0, 0),
      BodyPartKey.liver: (0, 0),
    };
    for (final entry in expected.entries) {
      expect(byPart[entry.key]?.thumbUpPoints, entry.value.$1);
      expect(byPart[entry.key]?.thumbDownPoints, entry.value.$2);
    }
  });

  test('paid plans allow the Mind score to reach ten', () async {
    final rewards = RewardsRepository(database);
    await rewards.initialize(now: DateTime.now());
    await rewards.setPlan(MembershipPlan.pro, now: DateTime.now());

    PersistedBodyState? body;
    for (var index = 0; index < 8; index++) {
      body = await repository.recordHabit('practising_gratitude');
    }
    expect(body!.parts[BodyPartKey.brain]?.score, 10);
    expect(body.parts[BodyPartKey.brain]?.level, 10);
    expect(body.parts[BodyPartKey.heart]?.score, 3);
  });

  test('Pro habits require Pro or Ultra access', () {
    for (final id in proHabitIds) {
      expect(minimumPlanForHabit(id), MembershipPlan.pro);
      expect(planCanUseHabit(MembershipPlan.free, id), isFalse);
      expect(planCanUseHabit(MembershipPlan.plus, id), isFalse);
      expect(planCanUseHabit(MembershipPlan.pro, id), isTrue);
      expect(planCanUseHabit(MembershipPlan.ultra, id), isTrue);
    }
  });

  test('two custom habits persist without changing body progress', () async {
    final before = await repository.loadBodyState();
    final goodId = await repository.createCustomHabit(
      name: 'Read a chapter',
      isUnwanted: false,
    );
    final badId = await repository.createCustomHabit(
      name: 'Late scrolling',
      isUnwanted: true,
    );
    await repository.recordHabit(goodId);
    await repository.recordHabit(badId);
    final after = await repository.loadBodyState();
    expect(
      after.parts[BodyPartKey.brain]?.score,
      before.parts[BodyPartKey.brain]?.score,
    );

    final preferences = await repository.watchHabitPreferences().first;
    expect(
      preferences.singleWhere((habit) => habit.id == goodId).category,
      'custom_good',
    );
    expect(
      preferences.singleWhere((habit) => habit.id == badId).category,
      'custom_bad',
    );
    await expectLater(
      repository.createCustomHabit(name: 'Third habit', isUnwanted: false),
      throwsA(isA<StateError>()),
    );
  });

  test('custom habits can be edited and deleted to free a slot', () async {
    final id = await repository.createCustomHabit(
      name: 'Read',
      isUnwanted: false,
    );
    await repository.updateCustomHabit(
      habitId: id,
      name: 'Read daily',
      isUnwanted: true,
    );

    var preferences = await repository.watchHabitPreferences().first;
    final edited = preferences.singleWhere((habit) => habit.id == id);
    expect(edited.nameKey, 'Read daily');
    expect(edited.category, 'custom_bad');

    await repository.deleteCustomHabit(id);
    preferences = await repository.watchHabitPreferences().first;
    expect(preferences.any((habit) => habit.id == id), isFalse);

    final replacement = await repository.createCustomHabit(
      name: 'Replacement',
      isUnwanted: false,
    );
    expect(replacement, startsWith('custom_replacement_'));
  });

  test('Pro allows five custom habits and Ultra allows ten', () async {
    final rewards = RewardsRepository(database);
    await rewards.initialize(now: DateTime(2026, 8, 25));
    await rewards.setPlan(MembershipPlan.pro, now: DateTime(2026, 8, 25));

    for (var index = 0; index < 5; index++) {
      await repository.createCustomHabit(
        name: 'Pro habit $index',
        isUnwanted: false,
      );
    }
    await expectLater(
      repository.createCustomHabit(name: 'Sixth Pro habit', isUnwanted: false),
      throwsA(isA<StateError>()),
    );

    await rewards.setPlan(MembershipPlan.ultra, now: DateTime(2026, 8, 25));
    for (var index = 5; index < 10; index++) {
      await repository.createCustomHabit(
        name: 'Ultra habit $index',
        isUnwanted: index.isOdd,
      );
    }
    await expectLater(
      repository.createCustomHabit(
        name: 'Eleventh Ultra habit',
        isUnwanted: true,
      ),
      throwsA(isA<StateError>()),
    );
  });

  test(
    'custom thumb effects update organs and respect the Pro quota',
    () async {
      final rewards = RewardsRepository(database);
      await rewards.initialize(now: DateTime(2026, 8, 25));
      await rewards.setPlan(MembershipPlan.pro, now: DateTime(2026, 8, 25));

      final goodId = await repository.createCustomHabit(
        name: 'Focused morning',
        isUnwanted: false,
        organEffects: const [
          CustomHabitOrganEffect(
            partKey: BodyPartKey.brain,
            thumbUpPoints: 1.5,
            thumbDownPoints: -.5,
          ),
        ],
      );
      var body = await repository.recordHabit(goodId, didHabit: true);
      expect(body.parts[BodyPartKey.brain]?.score, 4.5);
      body = await repository.recordHabit(goodId, didHabit: false);
      expect(body.parts[BodyPartKey.brain]?.score, 4.0);

      final unwantedId = await repository.createCustomHabit(
        name: 'Late phone use',
        isUnwanted: true,
        organEffects: const [
          CustomHabitOrganEffect(
            partKey: BodyPartKey.heart,
            thumbUpPoints: 1,
            thumbDownPoints: -1,
          ),
        ],
      );
      body = await repository.recordHabit(unwantedId, didHabit: false);
      expect(body.parts[BodyPartKey.heart]?.score, 4.0);

      await repository.createCustomHabit(
        name: 'Third affected habit',
        isUnwanted: false,
        organEffects: const [
          CustomHabitOrganEffect(
            partKey: BodyPartKey.gut,
            thumbUpPoints: .5,
            thumbDownPoints: 0,
          ),
        ],
      );
      await expectLater(
        repository.createCustomHabit(
          name: 'Fourth affected habit',
          isUnwanted: false,
          organEffects: const [
            CustomHabitOrganEffect(
              partKey: BodyPartKey.lungs,
              thumbUpPoints: .5,
              thumbDownPoints: 0,
            ),
          ],
        ),
        throwsA(isA<StateError>()),
      );
    },
  );

  test('Pro can override two existing habits and restore defaults', () async {
    final rewards = RewardsRepository(database);
    await rewards.initialize(now: DateTime(2026, 8, 25));
    await rewards.setPlan(MembershipPlan.pro, now: DateTime(2026, 8, 25));

    final waterDefaults = await repository.loadStandardHabitOrganEffects(
      'water',
    );
    expect(waterDefaults.isCustomized, isFalse);
    await repository.saveStandardHabitOrganEffects('water', [
      for (final effect in waterDefaults.effects)
        CustomHabitOrganEffect(
          partKey: effect.partKey,
          thumbUpPoints: effect.partKey == BodyPartKey.kidneys
              ? .5
              : effect.thumbUpPoints,
          thumbDownPoints: effect.thumbDownPoints,
        ),
    ]);
    var body = await repository.recordHabit('water', didHabit: true);
    expect(body.parts[BodyPartKey.kidneys]?.score, 3.5);

    final armDefaults = await repository.loadStandardHabitOrganEffects(
      'workout_arms',
    );
    await repository.saveStandardHabitOrganEffects('workout_arms', [
      for (final effect in armDefaults.effects)
        CustomHabitOrganEffect(
          partKey: effect.partKey,
          thumbUpPoints: effect.partKey == BodyPartKey.brain ? .5 : 0,
          thumbDownPoints: 0,
        ),
    ]);
    body = await repository.recordHabit('workout_arms', didHabit: true);
    expect(body.parts[BodyPartKey.brain]?.score, 4.5);
    expect(body.parts[BodyPartKey.arms]?.level, 1);

    final smoking = await repository.loadStandardHabitOrganEffects('smoking');
    await expectLater(
      repository.saveStandardHabitOrganEffects('smoking', [
        for (final effect in smoking.effects)
          CustomHabitOrganEffect(
            partKey: effect.partKey,
            thumbUpPoints: effect.partKey == BodyPartKey.lungs
                ? .5
                : effect.thumbUpPoints,
            thumbDownPoints: effect.thumbDownPoints,
          ),
      ]),
      throwsA(isA<StateError>()),
    );

    await repository.saveStandardHabitOrganEffects(
      'water',
      waterDefaults.effects,
    );
    expect(await repository.countStandardHabitsWithOrganEffects(), 1);
  });
}
