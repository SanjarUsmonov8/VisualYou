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
  Future<void> saveSpecialHabit({required int slot, String? habitId}) async {}

  @override
  Stream<CustomGraphSnapshot> watchSnapshot() {
    return Stream.value(const CustomGraphSnapshot(rules: [], days: []));
  }

  @override
  Stream<List<SpecialHabitGraph>> watchSpecialHabitGraphs() {
    return Stream.value(const []);
  }
}
