import 'package:visualyou/features/custom_graph/custom_graph_models.dart';
import 'package:visualyou/features/custom_graph/custom_graph_repository.dart';

class TestCustomGraphRepository implements CustomGraphRepository {
  const TestCustomGraphRepository();

  @override
  Future<List<CustomGraphHabit>> loadHabits() async => const [];

  @override
  Future<List<CustomGraphRule>> loadRules() async => const [];

  @override
  Future<void> saveRules(List<CustomGraphRule> rules) async {}

  @override
  Future<void> saveSpecialHabit({
    required int slot,
    String? habitId,
    int completedValue = 1,
    int missedValue = -1,
  }) async {}

  @override
  Stream<CustomGraphSnapshot> watchSnapshot({
    DateTime? endingOn,
    int dayCount = 7,
  }) {
    return Stream.value(const CustomGraphSnapshot(rules: [], days: []));
  }

  @override
  Stream<List<SpecialHabitGraph>> watchSpecialHabitGraphs({
    DateTime? endingOn,
    int dayCount = 7,
  }) {
    return Stream.value(const []);
  }

  @override
  Stream<List<NamedCustomGraph>> watchNamedGraphs({
    DateTime? endingOn,
    int dayCount = 7,
  }) => Stream.value(const []);

  @override
  Future<void> saveNamedGraph({
    required int graphSlot,
    required String name,
    required List<CustomGraphRule> rules,
  }) async {}

  @override
  Future<bool> isNamedGraphUnlocked(int graphSlot) async => false;

  @override
  Future<void> unlockNamedGraph(int graphSlot) async {}
}
