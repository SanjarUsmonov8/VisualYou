import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar.dart';
import 'package:visualyou/features/reduction_calendar/reduction_calendar_models.dart';

void main() {
  test('hard mode increases the gap after every checkpoint', () {
    final start = DateTime(2026, 7, 29);
    const expectedOffsets = [0, 2, 5, 9, 14, 20];

    for (var offset = 0; offset <= 20; offset++) {
      expect(
        isHardCheckpoint(start, start.add(Duration(days: offset))),
        expectedOffsets.contains(offset),
        reason: 'Unexpected hard-mode result at day offset $offset',
      );
    }
  });

  test('medium mode repeats each gap and expands its allowed window', () {
    final start = DateTime(2026, 8, 3);
    const expectedAllowedOffsets = [0, 1, 3, 5, 8, 9, 12, 13, 16, 17, 21, 22];

    for (var offset = 0; offset <= 22; offset++) {
      expect(
        isMediumAllowedDay(start, start.add(Duration(days: offset))),
        expectedAllowedOffsets.contains(offset),
        reason: 'Unexpected medium-mode result at day offset $offset',
      );
    }
  });

  test('medium allowed windows shrink again at long gaps', () {
    expect(mediumAllowedDaysForGap(2), 1);
    expect(mediumAllowedDaysForGap(3), 2);
    expect(mediumAllowedDaysForGap(9), 2);
    expect(mediumAllowedDaysForGap(10), 3);
    expect(mediumAllowedDaysForGap(20), 4);
    expect(mediumAllowedDaysForGap(50), 3);
    expect(mediumAllowedDaysForGap(70), 2);
    expect(mediumAllowedDaysForGap(100), 1);
  });

  test('medium movable allowance can replace an earlier scheduled day', () {
    final start = DateTime(2026, 8, 3);
    final substitutedDay = start.add(const Duration(days: 6));
    final plan = ReductionCalendarData(
      planId: 'medium-plan',
      habitId: 'smoking',
      habitNameKey: 'Smoking',
      mode: 'medium',
      startedOn: start,
      logCounts: {substitutedDay: 1},
    );

    expect(isMediumAllowedDay(start, substitutedDay), isFalse);
    expect(isReductionViolation(plan, substitutedDay), isFalse);
    expect(
      isMediumScheduledSlotConsumed(plan, start.add(const Duration(days: 8))),
      isTrue,
    );
    expect(
      isMediumScheduledSlotConsumed(plan, start.add(const Duration(days: 9))),
      isFalse,
    );
  });

  test('medium keeps the last day fixed and rejects extra movable uses', () {
    final start = DateTime(2026, 8, 3);
    final firstSubstitution = start.add(const Duration(days: 6));
    final extraUse = start.add(const Duration(days: 7));
    final fixedDay = start.add(const Duration(days: 9));
    final plan = ReductionCalendarData(
      planId: 'medium-plan',
      habitId: 'smoking',
      habitNameKey: 'Smoking',
      mode: 'medium',
      startedOn: start,
      logCounts: {firstSubstitution: 1, extraUse: 1, fixedDay: 1},
    );

    expect(isReductionViolation(plan, firstSubstitution), isFalse);
    expect(isReductionViolation(plan, extraUse), isTrue);
    expect(isReductionViolation(plan, fixedDay), isFalse);
  });

  test('easy starts with five allowed days and then one stay-free day', () {
    final start = DateTime(2026, 8, 3);
    const expectedAllowedOffsets = [0, 1, 2, 3, 4, 6, 7, 8, 9, 11, 12, 13, 14];

    for (var offset = 0; offset <= 14; offset++) {
      expect(
        isEasyAllowedDay(start, start.add(Duration(days: offset))),
        expectedAllowedOffsets.contains(offset),
        reason: 'Unexpected easy-mode result at day offset $offset',
      );
    }
  });

  test('easy allowance changes after four and ten cycle lengths', () {
    expect(easyAllowedDaysForGap(2), 4);
    expect(easyAllowedDaysForGap(5), 4);
    expect(easyAllowedDaysForGap(6), 3);
    expect(easyAllowedDaysForGap(11), 3);
    expect(easyAllowedDaysForGap(12), mediumAllowedDaysForGap(12));
  });

  test(
    'easy movable day can replace a scheduled day but not the fixed day',
    () {
      final start = DateTime(2026, 8, 3);
      final substitutedDay = start.add(const Duration(days: 5));
      final firstScheduledDay = start.add(const Duration(days: 6));
      final fixedDay = start.add(const Duration(days: 9));
      final plan = ReductionCalendarData(
        planId: 'easy-plan',
        habitId: 'smoking',
        habitNameKey: 'Smoking',
        mode: 'easy',
        startedOn: start,
        logCounts: {substitutedDay: 1},
      );

      expect(isReductionViolation(plan, substitutedDay), isFalse);
      expect(isFlexibleScheduledSlotConsumed(plan, firstScheduledDay), isTrue);
      expect(isFlexibleScheduledSlotConsumed(plan, fixedDay), isFalse);
    },
  );
}
