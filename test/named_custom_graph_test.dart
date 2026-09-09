import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/custom_graph/custom_graph_models.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

void main() {
  late AppDatabase database;
  late DriftCustomGraphRepository graphs;
  late RewardsController rewards;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    await DriftHabitRepository(database).initialize();
    rewards = RewardsController(RewardsRepository(database));
    await rewards.initialize();
    graphs = DriftCustomGraphRepository(database);
  });

  tearDown(() => database.close());

  test('plan graph limits match Free, Plus, Pro, and Ultra', () async {
    expect(rewards.customGraphLimit, 3);
    expect(rewards.namedCustomGraphLimit, 0);
    expect(rewards.specialGraphLimit, 2);
    expect(rewards.includedSpecialGraphLimit, 2);

    await rewards.setPlan(MembershipPlan.plus);
    expect(rewards.customGraphLimit, 6);
    expect(rewards.paidCustomGraphSlotStart, 3);
    expect(rewards.namedCustomGraphLimit, 1);
    expect(rewards.specialGraphLimit, 4);
    expect(rewards.includedSpecialGraphLimit, 2);

    await rewards.setPlan(MembershipPlan.pro);
    expect(rewards.customGraphLimit, 10);
    expect(rewards.paidCustomGraphSlotStart, 6);
    expect(rewards.namedCustomGraphLimit, 4);
    expect(rewards.specialGraphLimit, 8);
    expect(rewards.includedSpecialGraphLimit, 4);

    await rewards.setPlan(MembershipPlan.ultra);
    expect(rewards.hasUnlimitedCustomGraphHabits, isTrue);
    expect(rewards.paidCustomGraphSlotStart, isNull);
    expect(rewards.namedCustomGraphLimit, 6);
    expect(rewards.specialGraphLimit, isNull);
    expect(rewards.hasUnlimitedSpecialGraphs, isTrue);
  });

  test('Plus named graph requires unlock and stores grouped rules', () async {
    await rewards.setPlan(MembershipPlan.plus);
    final rules = [
      const CustomGraphRule(
        slot: 0,
        habitId: 'water',
        habitNameKey: 'Drinking water',
        completedPoints: 3,
        missedPoints: -2,
      ),
      const CustomGraphRule(
        slot: 1,
        habitId: 'smoking',
        habitNameKey: 'Smoking',
        completedPoints: -4,
        missedPoints: 3,
      ),
    ];
    await expectLater(
      graphs.saveNamedGraph(graphSlot: 0, name: 'Morning', rules: rules),
      throwsStateError,
    );

    await graphs.unlockNamedGraph(0);
    await graphs.saveNamedGraph(graphSlot: 0, name: 'Morning', rules: rules);
    final stored = await graphs.watchNamedGraphs().first;
    expect(stored.single.name, 'Morning');
    expect(stored.single.snapshot.rules, hasLength(2));
    expect(stored.single.snapshot.days, hasLength(7));
  });

  test('Pro includes two named graphs and locks the other two', () async {
    await rewards.setPlan(MembershipPlan.pro);
    const rule = CustomGraphRule(
      slot: 0,
      habitId: 'water',
      habitNameKey: 'Drinking water',
      completedPoints: 2,
      missedPoints: -1,
    );
    await graphs.saveNamedGraph(
      graphSlot: 1,
      name: 'Included',
      rules: const [rule],
    );
    await expectLater(
      graphs.saveNamedGraph(graphSlot: 2, name: 'Locked', rules: const [rule]),
      throwsStateError,
    );
    await graphs.unlockNamedGraph(2);
    await graphs.saveNamedGraph(
      graphSlot: 2,
      name: 'Unlocked',
      rules: const [rule],
    );
    expect(await graphs.watchNamedGraphs().first, hasLength(2));
  });
}
