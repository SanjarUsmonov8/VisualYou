import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

void main() {
  late AppDatabase database;
  late DriftHabitRepository habits;
  late RewardsRepository rewards;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    habits = DriftHabitRepository(database);
    rewards = RewardsRepository(database);
    await habits.initialize();
    await rewards.initialize(now: DateTime(2026, 8, 3, 9));
  });

  tearDown(() => database.close());

  test('starts with the profile reward and default graph choices', () async {
    final snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 3));
    expect(snapshot.plan, MembershipPlan.free);
    expect(snapshot.tokenBalance, 140);
    expect(snapshot.profileProgress, 140);
    expect(snapshot.bodyProgress, 0);
    expect(snapshot.calendarProgress, 0);
    expect(
      snapshot.isFeatureUnlocked(GatedFeature.body, DateTime(2026, 8, 3)),
      isTrue,
    );

    final rules = await database.select(database.customGraphRules).get();
    expect(rules.map((rule) => rule.habitId), [
      'healthy_eating',
      'alcohol',
      'smoking',
    ]);
    final special = await database.select(database.specialHabitGraphs).get();
    expect(special.map((graph) => graph.habitId), ['alcohol', 'water']);
  });

  test('token spending and weekly unlock persist locally', () async {
    final success = await rewards.unlockFeature(
      GatedFeature.graphs,
      now: DateTime(2026, 8, 10, 10),
    );
    expect(success, isTrue);

    final snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 10));
    expect(snapshot.tokenBalance, 70);
    expect(
      snapshot.isFeatureUnlocked(GatedFeature.graphs, DateTime(2026, 8, 16)),
      isTrue,
    );
    expect(
      snapshot.isFeatureUnlocked(GatedFeature.graphs, DateTime(2026, 8, 18)),
      isFalse,
    );
  });

  test('streak aid costs 35 tokens and bridges at most two misses', () async {
    expect(
      await rewards.purchaseStreakAid(now: DateTime(2026, 8, 3, 10)),
      isTrue,
    );
    var snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 3));
    expect(snapshot.tokenBalance, 105);
    expect(snapshot.streakAidBalance, 1);

    await habits.recordHabit(
      'Drinking water',
      occurredAt: DateTime(2026, 8, 3, 8),
    );
    await rewards.refresh(now: DateTime(2026, 8, 5, 9));
    snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 5));
    expect(snapshot.streakAidBalance, 0);
    expect(snapshot.currentStreak, 1);
    expect(snapshot.protectedStreakDays, contains(DateTime(2026, 8, 4)));
    expect(snapshot.protectedStreakDays, contains(DateTime(2026, 8, 5)));

    await rewards.refresh(now: DateTime(2026, 8, 6, 9));
    expect(
      (await rewards.loadSnapshot(now: DateTime(2026, 8, 6))).currentStreak,
      1,
    );

    await rewards.refresh(now: DateTime(2026, 8, 7, 9));
    expect(
      (await rewards.loadSnapshot(now: DateTime(2026, 8, 7))).currentStreak,
      0,
    );
  });

  test('streak and completed-week rewards cannot be awarded twice', () async {
    for (var offset = 0; offset < 7; offset++) {
      await habits.recordHabit(
        'Drinking water',
        occurredAt: DateTime(2026, 8, 3 + offset, 8),
      );
    }

    await rewards.refresh(now: DateTime(2026, 8, 10, 9));
    final first = await rewards.loadSnapshot(now: DateTime(2026, 8, 10));
    expect(first.currentStreak, 7);
    expect(first.tokenBalance, greaterThan(140));
    expect(first.calendarProgress, 10);

    await rewards.refresh(now: DateTime(2026, 8, 10, 10));
    final second = await rewards.loadSnapshot(now: DateTime(2026, 8, 10));
    expect(second.tokenBalance, first.tokenBalance);
    expect(second.calendarProgress, first.calendarProgress);
    expect(second.bodyProgress, first.bodyProgress);
  });

  test(
    'Plus selection gives one monthly bonus and removes feature locks',
    () async {
      await rewards.setPlan(MembershipPlan.plus, now: DateTime(2026, 8, 4));
      await rewards.setPlan(MembershipPlan.plus, now: DateTime(2026, 8, 20));
      final snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 20));
      expect(snapshot.isPlus, isTrue);
      expect(snapshot.planExpiresAt, DateTime(2026, 9, 20));
      expect(snapshot.tokenBalance, 210);
      expect(snapshot.profileProgress, 210);
      expect(
        snapshot.isFeatureUnlocked(GatedFeature.body, DateTime(2026, 8, 25)),
        isTrue,
      );

      expect(
        await rewards.spendTokens(
          amount: 35,
          reason: 'premium-extra-slot',
          chargePlus: true,
          now: DateTime(2026, 8, 21),
        ),
        isTrue,
      );
      expect(
        (await rewards.loadSnapshot(now: DateTime(2026, 8, 21))).tokenBalance,
        175,
      );

      await rewards.refresh(now: DateTime(2026, 9, 1));
      final nextMonth = await rewards.loadSnapshot(now: DateTime(2026, 9, 1));
      expect(nextMonth.tokenBalance, 245);
      expect(nextMonth.profileProgress, 280);
    },
  );

  test('Pro and Ultra plans persist and inherit paid access', () async {
    await rewards.setPlan(MembershipPlan.pro, now: DateTime(2026, 8, 20));
    var snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 20));
    expect(snapshot.plan, MembershipPlan.pro);
    expect(snapshot.isPaid, isTrue);
    expect(snapshot.isPlus, isTrue);
    expect(snapshot.isPro, isTrue);
    expect(snapshot.planExpiresAt, DateTime(2026, 9, 20));
    expect(
      snapshot.isFeatureUnlocked(GatedFeature.body, DateTime(2026, 8, 25)),
      isTrue,
    );

    await rewards.setPlan(MembershipPlan.ultra, now: DateTime(2026, 8, 21));
    snapshot = await rewards.loadSnapshot(now: DateTime(2026, 8, 21));
    expect(snapshot.plan, MembershipPlan.ultra);
    expect(snapshot.isUltra, isTrue);
    expect(snapshot.planExpiresAt, DateTime(2026, 9, 21));

    await rewards.refresh(now: DateTime(2026, 9, 22));
    snapshot = await rewards.loadSnapshot(now: DateTime(2026, 9, 22));
    expect(snapshot.plan, MembershipPlan.free);
    expect(snapshot.planExpiresAt, isNull);
  });
}
