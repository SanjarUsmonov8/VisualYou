class NumericalHeatmapData {
  const NumericalHeatmapData({
    required this.slot,
    required this.habitId,
    required this.habitNameKey,
    required this.unitKey,
    required this.higherIsBetter,
    required this.orangeThreshold,
    required this.yellowThreshold,
    required this.greenThreshold,
    required this.blueThreshold,
    required this.createdAt,
    required this.outcomeByDay,
    required this.valueByDay,
  });

  final int slot;
  final String habitId;
  final String habitNameKey;
  final String? unitKey;
  final bool higherIsBetter;
  final int orangeThreshold;
  final int yellowThreshold;
  final int greenThreshold;
  final int blueThreshold;
  final DateTime createdAt;
  final Map<DateTime, double> outcomeByDay;
  final Map<DateTime, int?> valueByDay;
}

class NumericalHeatmapHabit {
  const NumericalHeatmapHabit({
    required this.id,
    required this.nameKey,
    required this.unitKey,
    required this.target,
  });

  final String id;
  final String nameKey;
  final String unitKey;
  final int target;
}

class NumericalHeatmapSetup {
  const NumericalHeatmapSetup({
    required this.habitId,
    required this.higherIsBetter,
    required this.orangeThreshold,
    required this.yellowThreshold,
    required this.greenThreshold,
    required this.blueThreshold,
  });

  final String habitId;
  final bool higherIsBetter;
  final int orangeThreshold;
  final int yellowThreshold;
  final int greenThreshold;
  final int blueThreshold;
}
