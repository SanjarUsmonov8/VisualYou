class HabitStreakData {
  const HabitStreakData({
    required this.habitId,
    required this.habitNameKey,
    required this.category,
    required this.createdAt,
    required this.dayResults,
    this.colorValue,
  });

  final String habitId;
  final String habitNameKey;
  final String category;
  final DateTime createdAt;
  final int? colorValue;
  final Map<DateTime, bool> dayResults;

  bool get isUnwanted => category == 'reduction' || category == 'custom_bad';

  Set<DateTime> get successfulDays => {
    for (final entry in dayResults.entries)
      if (entry.value) entry.key,
  };

  int currentStreak({DateTime? now}) {
    final value = now ?? DateTime.now();
    final today = DateTime(value.year, value.month, value.day);
    final todayResult = dayResults[today];
    if (todayResult == false) return 0;
    var cursor = todayResult == true
        ? today
        : today.subtract(const Duration(days: 1));
    var count = 0;
    while (dayResults[cursor] == true) {
      count++;
      cursor = cursor.subtract(const Duration(days: 1));
    }
    return count;
  }
}

class HabitStreakHabit {
  const HabitStreakHabit({
    required this.id,
    required this.nameKey,
    required this.category,
  });

  final String id;
  final String nameKey;
  final String category;
}
