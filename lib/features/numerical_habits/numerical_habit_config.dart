enum NumericalHabitKind {
  balancedAmount,
  positiveDuration,
  positiveOccurrences,
  limitedDuration,
  occurrences,
}

abstract final class NumericalHabitUnit {
  static const times = 'times';
  static const minutes = 'minutes';

  static const values = {times, minutes};
}

class NumericalHabitConfig {
  const NumericalHabitConfig({
    required this.kind,
    required this.unitKey,
    required this.defaultTarget,
    required this.maximum,
    required this.step,
  });

  final NumericalHabitKind kind;
  final String unitKey;
  final int defaultTarget;
  final int maximum;
  final int step;

  double outcomeFactor(int value, int target) {
    final safeTarget = target.clamp(1, maximum);
    switch (kind) {
      case NumericalHabitKind.balancedAmount:
        final distance = (value - safeTarget).abs();
        if (distance <= step) return 1;
        return -((distance - step) / (safeTarget - step).clamp(1, maximum))
            .clamp(0.0, 1.0);
      case NumericalHabitKind.positiveDuration:
        if (value == 0) return -1;
        if (value <= step) return 0;
        final progress = (value - step) / (safeTarget - step).clamp(1, maximum);
        return (.25 + (.75 * progress)).clamp(.25, 1.0);
      case NumericalHabitKind.positiveOccurrences:
        if (value == 0) return -1;
        return (value / safeTarget).clamp(.0, 1.0);
      case NumericalHabitKind.limitedDuration:
        return ((safeTarget - value) / safeTarget).clamp(-1.0, 1.0);
      case NumericalHabitKind.occurrences:
        if (value == 0) return 1;
        return -(value / safeTarget).clamp(0.0, 1.0);
    }
  }
}

const numericalHabitConfigs = <String, NumericalHabitConfig>{
  'water': NumericalHabitConfig(
    kind: NumericalHabitKind.balancedAmount,
    unitKey: 'glasses',
    defaultTarget: 8,
    maximum: 20,
    step: 1,
  ),
  'studying': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 240,
    step: 5,
  ),
  'reading': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 240,
    step: 5,
  ),
  'workout_arms': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 180,
    step: 5,
  ),
  'workout_shoulders': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 180,
    step: 5,
  ),
  'workout_back': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 180,
    step: 5,
  ),
  'workout_chest': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 180,
    step: 5,
  ),
  'workout_abs': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 180,
    step: 5,
  ),
  'workout_legs': NumericalHabitConfig(
    kind: NumericalHabitKind.positiveDuration,
    unitKey: 'minutes',
    defaultTarget: 30,
    maximum: 180,
    step: 5,
  ),
  'excessive_screen_time': NumericalHabitConfig(
    kind: NumericalHabitKind.limitedDuration,
    unitKey: 'minutes',
    defaultTarget: 120,
    maximum: 600,
    step: 15,
  ),
  'social_media_overuse': NumericalHabitConfig(
    kind: NumericalHabitKind.limitedDuration,
    unitKey: 'minutes',
    defaultTarget: 60,
    maximum: 480,
    step: 15,
  ),
  'gaming_overuse': NumericalHabitConfig(
    kind: NumericalHabitKind.limitedDuration,
    unitKey: 'minutes',
    defaultTarget: 60,
    maximum: 480,
    step: 15,
  ),
  'smoking': NumericalHabitConfig(
    kind: NumericalHabitKind.occurrences,
    unitKey: 'times',
    defaultTarget: 10,
    maximum: 50,
    step: 1,
  ),
  'vaping': NumericalHabitConfig(
    kind: NumericalHabitKind.occurrences,
    unitKey: 'times',
    defaultTarget: 10,
    maximum: 50,
    step: 1,
  ),
  'alcohol': NumericalHabitConfig(
    kind: NumericalHabitKind.occurrences,
    unitKey: 'drinks',
    defaultTarget: 3,
    maximum: 20,
    step: 1,
  ),
  'masturbation': NumericalHabitConfig(
    kind: NumericalHabitKind.occurrences,
    unitKey: 'times',
    defaultTarget: 2,
    maximum: 15,
    step: 1,
  ),
};

bool numericalCategoryIsUnwanted(String category) =>
    category == 'reduction' || category == 'custom_bad';

String defaultNumericalUnitForHabit(String habitId) =>
    numericalHabitConfigs[habitId]?.unitKey ?? NumericalHabitUnit.times;

String selectableNumericalUnitForHabit(String habitId) =>
    defaultNumericalUnitForHabit(habitId) == NumericalHabitUnit.minutes
    ? NumericalHabitUnit.minutes
    : NumericalHabitUnit.times;

NumericalHabitConfig numericalConfigForHabit({
  required String habitId,
  required String category,
  String? unitKey,
}) {
  final unwanted = numericalCategoryIsUnwanted(category);
  final existing = numericalHabitConfigs[habitId];
  if (unitKey != null &&
      !NumericalHabitUnit.values.contains(unitKey) &&
      existing != null) {
    return existing;
  }
  if (unitKey == null && existing != null) return existing;
  final unit = NumericalHabitUnit.values.contains(unitKey)
      ? unitKey!
      : NumericalHabitUnit.times;

  if (unit == NumericalHabitUnit.minutes) {
    if (existing?.unitKey == NumericalHabitUnit.minutes) return existing!;
    return NumericalHabitConfig(
      kind: unwanted
          ? NumericalHabitKind.limitedDuration
          : NumericalHabitKind.positiveDuration,
      unitKey: NumericalHabitUnit.minutes,
      defaultTarget: unwanted ? 60 : 30,
      maximum: 1440,
      step: 5,
    );
  }

  if (existing != null &&
      existing.unitKey != NumericalHabitUnit.minutes &&
      existing.kind == NumericalHabitKind.occurrences) {
    return NumericalHabitConfig(
      kind: existing.kind,
      unitKey: NumericalHabitUnit.times,
      defaultTarget: existing.defaultTarget,
      maximum: existing.maximum,
      step: 1,
    );
  }
  return NumericalHabitConfig(
    kind: unwanted
        ? NumericalHabitKind.occurrences
        : NumericalHabitKind.positiveOccurrences,
    unitKey: NumericalHabitUnit.times,
    defaultTarget: unwanted ? 1 : 1,
    maximum: 100,
    step: 1,
  );
}
