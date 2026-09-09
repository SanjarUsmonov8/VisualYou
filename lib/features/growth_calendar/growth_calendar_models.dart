import 'dart:math' as math;

import 'package:visualyou/features/custom_graph/custom_graph_models.dart';

enum GrowthMode { fast, medium, slow }

enum GrowthMeasurementUnit { times, minutes }

class GrowthCalendarData {
  const GrowthCalendarData({
    required this.planId,
    required this.habitId,
    required this.habitNameKey,
    required this.mode,
    required this.startedOn,
    required this.targetDaysPerWeek,
    required this.targetRepetitionsPerDay,
    required this.offWeekdays,
    required this.completedCounts,
    this.weekdayRepetitions = const {},
    this.measurementUnit = GrowthMeasurementUnit.times,
  });

  final String planId;
  final String habitId;
  final String habitNameKey;
  final GrowthMode mode;
  final DateTime startedOn;
  final int targetDaysPerWeek;
  final int targetRepetitionsPerDay;
  final Set<int> offWeekdays;
  final Map<int, int> weekdayRepetitions;
  final GrowthMeasurementUnit measurementUnit;
  final Map<DateTime, int> completedCounts;

  int completedOn(DateTime day) =>
      completedCounts[DateTime(day.year, day.month, day.day)] ?? 0;

  bool hasStatusOn(DateTime day) =>
      completedCounts.containsKey(DateTime(day.year, day.month, day.day));

  GrowthDayTarget targetOn(DateTime day) => GrowthSchedule.targetFor(this, day);
}

class GrowthDayTarget {
  const GrowthDayTarget({
    required this.scheduled,
    required this.repetitions,
    required this.weeklyFrequency,
  });

  const GrowthDayTarget.off()
    : scheduled = false,
      repetitions = 0,
      weeklyFrequency = 0;

  final bool scheduled;
  final int repetitions;
  final int weeklyFrequency;
}

class GrowthSchedule {
  const GrowthSchedule._();

  static GrowthDayTarget targetFor(GrowthCalendarData plan, DateTime day) {
    final normalizedDay = DateTime(day.year, day.month, day.day);
    final start = DateTime(
      plan.startedOn.year,
      plan.startedOn.month,
      plan.startedOn.day,
    );
    if (normalizedDay.isBefore(start) ||
        plan.offWeekdays.contains(normalizedDay.weekday)) {
      return const GrowthDayTarget.off();
    }

    final startWeek = start.subtract(Duration(days: start.weekday - 1));
    final dayWeek = normalizedDay.subtract(
      Duration(days: normalizedDay.weekday - 1),
    );
    final weekIndex = dayWeek.difference(startWeek).inDays ~/ 7;
    if (weekIndex < 0) return const GrowthDayTarget.off();

    final availableWeekdays = [
      for (var weekday = DateTime.monday; weekday <= DateTime.sunday; weekday++)
        if (!plan.offWeekdays.contains(weekday)) weekday,
    ];
    if (availableWeekdays.isEmpty) return const GrowthDayTarget.off();

    final maximumFrequency = math.min(
      plan.targetDaysPerWeek.clamp(1, 7),
      availableWeekdays.length,
    );
    final maximumTarget = math.max(
      math.max(1, plan.targetRepetitionsPerDay),
      plan.weekdayRepetitions.values.fold<int>(1, math.max),
    );
    final targetStep = plan.measurementUnit == GrowthMeasurementUnit.minutes
        ? 15
        : 1;
    final maximumLevels = (maximumTarget / targetStep).ceil();
    var remainingWeeks = weekIndex;
    var weeklyFrequency = maximumFrequency;
    var repetitions = math.min(targetStep, maximumTarget);

    for (var level = 1; level <= maximumFrequency; level++) {
      final duration = _weeksAtLevel(plan.mode, level);
      if (remainingWeeks < duration) {
        weeklyFrequency = level;
        break;
      }
      remainingWeeks -= duration;
    }

    final frequencyPhaseWeeks = [
      for (var level = 1; level <= maximumFrequency; level++)
        _weeksAtLevel(plan.mode, level),
    ].fold<int>(0, (sum, value) => sum + value);
    if (weekIndex >= frequencyPhaseWeeks) {
      weeklyFrequency = maximumFrequency;
      remainingWeeks = weekIndex - frequencyPhaseWeeks;
      repetitions = maximumTarget;
      for (var level = 2; level <= maximumLevels; level++) {
        final duration = _weeksAtLevel(plan.mode, level);
        if (remainingWeeks < duration) {
          repetitions = math.min(level * targetStep, maximumTarget);
          break;
        }
        remainingWeeks -= duration;
      }
    }

    final usableWeekdays = weekIndex == 0
        ? availableWeekdays
              .where((weekday) => weekday >= start.weekday)
              .toList()
        : availableWeekdays;
    final completeSchedule = _spreadAcrossWeek(
      usableWeekdays,
      math.min(maximumFrequency, usableWeekdays.length),
    ).toList()..sort();
    final selected = completeSchedule
        .take(math.min(weeklyFrequency, completeSchedule.length))
        .toSet();
    final dayMaximum = math.max(
      targetStep,
      plan.weekdayRepetitions[normalizedDay.weekday] ??
          plan.targetRepetitionsPerDay,
    );
    final dayRepetitions = math.min(repetitions, dayMaximum);
    return GrowthDayTarget(
      scheduled: selected.contains(normalizedDay.weekday),
      repetitions: selected.contains(normalizedDay.weekday)
          ? dayRepetitions
          : 0,
      weeklyFrequency: weeklyFrequency,
    );
  }

  static int _weeksAtLevel(GrowthMode mode, int level) => switch (mode) {
    GrowthMode.fast => 1,
    GrowthMode.medium => level,
    GrowthMode.slow => level + 1,
  };

  static Set<int> _spreadAcrossWeek(List<int> weekdays, int count) {
    if (weekdays.isEmpty || count <= 0) return const {};
    if (count >= weekdays.length) return weekdays.toSet();
    if (count == 1) return {weekdays[(weekdays.length - 1) ~/ 2]};
    return {
      for (var index = 0; index < count; index++)
        weekdays[(index * (weekdays.length - 1) / (count - 1)).round()],
    };
  }
}

typedef GrowthHabit = CustomGraphHabit;
