import 'package:flutter/foundation.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

class RewardsController extends ChangeNotifier {
  RewardsController(this.repository);

  final RewardsRepository repository;
  RewardsSnapshot? _snapshot;
  bool _busy = false;

  RewardsSnapshot? get snapshot => _snapshot;
  bool get busy => _busy;
  bool get isPlus => _snapshot?.isPlus ?? false;
  MembershipPlan get plan => _snapshot?.plan ?? MembershipPlan.free;
  bool isPlan(MembershipPlan candidate) => plan == candidate;
  bool get isProOrHigher =>
      plan == MembershipPlan.pro || plan == MembershipPlan.ultra;
  bool get isUltra => plan == MembershipPlan.ultra;
  int get customGraphLimit => switch (plan) {
    MembershipPlan.free => 3,
    MembershipPlan.plus => 6,
    MembershipPlan.pro || MembershipPlan.ultra => 10,
  };
  bool get hasUnlimitedCustomGraphHabits => plan == MembershipPlan.ultra;
  int? get paidCustomGraphSlotStart => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 3,
    MembershipPlan.pro => 6,
    MembershipPlan.ultra => null,
  };
  int get namedCustomGraphLimit => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 1,
    MembershipPlan.pro => 4,
    MembershipPlan.ultra => 6,
  };
  int? get specialGraphLimit => switch (plan) {
    MembershipPlan.free => 2,
    MembershipPlan.plus => 4,
    MembershipPlan.pro => 8,
    MembershipPlan.ultra => null,
  };
  int get includedSpecialGraphLimit => switch (plan) {
    MembershipPlan.free || MembershipPlan.plus => 2,
    MembershipPlan.pro => 4,
    MembershipPlan.ultra => 1 << 30,
  };
  bool get hasUnlimitedSpecialGraphs => plan == MembershipPlan.ultra;
  int get reductionPlanLimit => switch (plan) {
    MembershipPlan.free => 1,
    MembershipPlan.plus => 2,
    MembershipPlan.pro => 4,
    MembershipPlan.ultra => 1 << 30,
  };
  int get growthPlanLimit => switch (plan) {
    MembershipPlan.free => 1,
    MembershipPlan.plus => 3,
    MembershipPlan.pro => 6,
    MembershipPlan.ultra => 1 << 30,
  };
  int get customHabitLimit => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 2,
    MembershipPlan.pro => 5,
    MembershipPlan.ultra => 10,
  };
  int get customHabitOrganEffectLimit => switch (plan) {
    MembershipPlan.pro => 3,
    MembershipPlan.ultra => 6,
    _ => 0,
  };
  int get standardHabitOrganEffectLimit => switch (plan) {
    MembershipPlan.pro => 2,
    MembershipPlan.ultra => 4,
    _ => 0,
  };
  int? get numericalHabitLimit => switch (plan) {
    MembershipPlan.free => 0,
    MembershipPlan.plus => 4,
    MembershipPlan.pro || MembershipPlan.ultra => null,
  };

  Future<void> initialize() async {
    await repository.initialize();
    _snapshot = await repository.loadSnapshot();
    notifyListeners();
  }

  Future<void> refresh() async {
    await repository.refresh();
    _snapshot = await repository.loadSnapshot();
    notifyListeners();
  }

  Future<void> setPlan(MembershipPlan plan) async {
    await repository.setPlan(plan);
    _snapshot = await repository.loadSnapshot();
    notifyListeners();
  }

  Future<bool> spend(
    int amount,
    String reason, {
    bool chargePlus = false,
  }) async {
    _busy = true;
    notifyListeners();
    final success = await repository.spendTokens(
      amount: amount,
      reason: reason,
      chargePlus: chargePlus,
    );
    _snapshot = await repository.loadSnapshot();
    _busy = false;
    notifyListeners();
    return success;
  }

  bool isUnlocked(GatedFeature feature) =>
      _snapshot?.isFeatureUnlocked(feature, DateTime.now()) ?? false;

  bool isPaidExtensionUnlocked(GatedFeature feature) =>
      _snapshot?.unlocks[feature]?.isAfter(DateTime.now()) ?? false;

  Future<bool> unlock(GatedFeature feature) async {
    _busy = true;
    notifyListeners();
    final success = await repository.unlockFeature(feature);
    _snapshot = await repository.loadSnapshot();
    _busy = false;
    notifyListeners();
    return success;
  }

  Future<bool> purchaseStreakAid() async {
    _busy = true;
    notifyListeners();
    try {
      final success = await repository.purchaseStreakAid();
      _snapshot = await repository.loadSnapshot();
      return success;
    } finally {
      _busy = false;
      notifyListeners();
    }
  }

  Future<void> awardRewardedAdTokens() async {
    _busy = true;
    notifyListeners();
    try {
      await repository.awardRewardedAdTokens();
      _snapshot = await repository.loadSnapshot();
    } finally {
      _busy = false;
      notifyListeners();
    }
  }
}
