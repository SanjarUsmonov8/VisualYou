import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/features/calendar/calendar_models.dart';

void main() {
  test('calendar score moves up for good and down for unwanted habits', () {
    CalendarDaySummary summary(List<CalendarActivity> activities) {
      return CalendarDaySummary(
        day: DateTime(2026, 7, 29),
        activities: activities,
      );
    }

    const good = CalendarActivity(
      habitId: 'water',
      habitNameKey: 'Drinking water',
      category: 'good',
      count: 2,
    );
    const unwanted = CalendarActivity(
      habitId: 'smoking',
      habitNameKey: 'Smoking',
      category: 'reduction',
      count: 1,
    );

    expect(summary([good]).score, 1);
    expect(summary([good]).level, CalendarPerformanceLevel.good);
    expect(summary([unwanted]).score, -1);
    expect(summary([unwanted]).level, CalendarPerformanceLevel.bad);
    expect(summary([good, unwanted]).score, 0);
    expect(summary([good, unwanted]).level, CalendarPerformanceLevel.okay);

    const missedGood = CalendarActivity(
      habitId: 'water',
      habitNameKey: 'Drinking water',
      category: 'good',
      count: 0,
    );
    const avoidedUnwanted = CalendarActivity(
      habitId: 'smoking',
      habitNameKey: 'Smoking',
      category: 'reduction',
      count: 0,
    );
    expect(summary([missedGood]).score, -1);
    expect(summary([avoidedUnwanted]).score, 1);
  });
}
