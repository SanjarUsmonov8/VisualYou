import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/main.dart';

import 'test_custom_graph_repository.dart';
import 'test_calendar_repository.dart';
import 'test_reduction_calendar_repository.dart';

void main() {
  testWidgets('custom graph appears beneath the body', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());

    await tester.pumpWidget(
      VisualYouApp(
        skipOnboarding: true,
        habitRepository: DriftHabitRepository(database),
        customGraphRepository: const TestCustomGraphRepository(),
        calendarRepository: const TestCalendarRepository(),
        reductionCalendarRepository: const TestReductionCalendarRepository(),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('Custom graph'), findsOneWidget);
    expect(find.byKey(const Key('editCustomGraphButton')), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await database.close();
  });
}
