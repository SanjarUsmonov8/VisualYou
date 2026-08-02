import 'package:visualyou/features/reduction_calendar/reduction_calendar_models.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_repository.dart';

class TestReductionCalendarRepository implements ReductionCalendarRepository {
  const TestReductionCalendarRepository();

  @override
  Future<void> createHardPlan({
    required String habitId,
    DateTime? startedOn,
  }) async {}

  @override
  Future<void> createMediumPlan({
    required String habitId,
    DateTime? startedOn,
  }) async {}

  @override
  Future<void> createEasyPlan({
    required String habitId,
    DateTime? startedOn,
  }) async {}

  @override
  Future<List<ReductionHabit>> loadUnwantedHabits() async => const [];

  @override
  Future<void> setDayStatus({
    required String planId,
    required DateTime day,
    required bool didHabit,
  }) async {}

  @override
  Stream<ReductionCalendarData?> watchMonth(DateTime month) {
    return Stream.value(null);
  }

  @override
  Stream<List<ReductionCalendarData>> watchPlansMonth(DateTime month) {
    return Stream.value(const []);
  }
}
