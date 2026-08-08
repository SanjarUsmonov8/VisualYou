enum CalendarPerformanceLevel { terrible, bad, okay, good, excellent }

class CalendarActivity {
  const CalendarActivity({
    required this.habitId,
    required this.habitNameKey,
    required this.category,
    required this.count,
  });

  final String habitId;
  final String habitNameKey;
  final String category;
  final int count;

  bool get isUnwanted => category == 'reduction' || category == 'custom_bad';

  int get score {
    final didHabit = count > 0;
    if (isUnwanted) return didHabit ? -1 : 1;
    return didHabit ? 1 : -1;
  }
}

class CalendarDaySummary {
  const CalendarDaySummary({required this.day, required this.activities});

  final DateTime day;
  final List<CalendarActivity> activities;

  int get score =>
      activities.fold(0, (total, activity) => total + activity.score);

  bool get hasActivity => activities.isNotEmpty;

  CalendarPerformanceLevel get level {
    return switch (score) {
      <= -2 => CalendarPerformanceLevel.terrible,
      -1 => CalendarPerformanceLevel.bad,
      0 => CalendarPerformanceLevel.okay,
      1 => CalendarPerformanceLevel.good,
      _ => CalendarPerformanceLevel.excellent,
    };
  }
}
