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
  int get customGraphLimit => isPlus ? 6 : 3;
  int get specialGraphLimit => isPlus ? 4 : 2;
  int get reductionPlanLimit => isPlus ? 2 : 1;

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
}
