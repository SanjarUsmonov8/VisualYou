import 'package:visualyou/features/custom_graph/custom_graph_models.dart';

class ReductionCalendarData {
  const ReductionCalendarData({
    required this.planId,
    required this.habitId,
    required this.habitNameKey,
    required this.mode,
    required this.startedOn,
    required this.logCounts,
  });

  final String planId;
  final String habitId;
  final String habitNameKey;
  final String mode;
  final DateTime startedOn;
  final Map<DateTime, int> logCounts;

  int countOn(DateTime day) {
    return logCounts[DateTime(day.year, day.month, day.day)] ?? 0;
  }

  bool hasStatusOn(DateTime day) {
    return logCounts.containsKey(DateTime(day.year, day.month, day.day));
  }
}

typedef ReductionHabit = CustomGraphHabit;
