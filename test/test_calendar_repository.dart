import 'package:visualyou/features/calendar/calendar_models.dart';
import 'package:visualyou/features/calendar/calendar_repository.dart';

class TestCalendarRepository implements CalendarRepository {
  const TestCalendarRepository();

  @override
  Stream<List<CalendarDaySummary>> watchMonth(DateTime month) {
    return Stream.value(const []);
  }
}
