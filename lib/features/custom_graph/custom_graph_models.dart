class CustomGraphHabit {
  const CustomGraphHabit({
    required this.id,
    required this.nameKey,
    required this.category,
    required this.numericalTrackingEnabled,
    this.numericalUnit,
  });

  final String id;
  final String nameKey;
  final String category;
  final bool numericalTrackingEnabled;
  final String? numericalUnit;
}

class CustomGraphRule {
  const CustomGraphRule({
    required this.slot,
    required this.habitId,
    required this.habitNameKey,
    required this.completedPoints,
    required this.missedPoints,
  });

  final int slot;
  final String habitId;
  final String habitNameKey;
  final int completedPoints;
  final int missedPoints;
}

class CustomGraphDay {
  const CustomGraphDay({required this.day, required this.values});

  final DateTime day;
  final Map<String, int> values;

  int get total => values.values.fold(0, (sum, value) => sum + value);
}

class CustomGraphSnapshot {
  const CustomGraphSnapshot({required this.rules, required this.days});

  final List<CustomGraphRule> rules;
  final List<CustomGraphDay> days;
}

class NamedCustomGraph {
  const NamedCustomGraph({
    required this.slot,
    required this.name,
    required this.snapshot,
  });

  final int slot;
  final String name;
  final CustomGraphSnapshot snapshot;
}

class SpecialHabitGraph {
  const SpecialHabitGraph({
    required this.slot,
    required this.habitId,
    required this.habitNameKey,
    required this.completedValue,
    required this.missedValue,
    required this.unitKey,
    required this.days,
  });

  final int slot;
  final String habitId;
  final String habitNameKey;
  final int completedValue;
  final int missedValue;
  final String? unitKey;
  final List<SpecialHabitGraphDay> days;
}

class SpecialHabitGraphDay {
  const SpecialHabitGraphDay({required this.day, required this.count});

  final DateTime day;
  final int count;
}
