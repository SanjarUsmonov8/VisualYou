import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/main.dart';

import 'test_calendar_repository.dart';
import 'test_custom_graph_repository.dart';
import 'test_reduction_calendar_repository.dart';

void main() {
  testWidgets('AI tab morphs navigation into a working chat composer', (
    tester,
  ) async {
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
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('AI coach'));
    await tester.pumpAndSettle();

    expect(find.byType(VisualYouNavigationBar), findsNothing);
    expect(find.text('AI coach'), findsOneWidget);
    expect(find.byTooltip('Add image'), findsOneWidget);
    expect(find.byTooltip('Back'), findsOneWidget);

    const prompt = 'How can I build a consistent workout routine?';
    await tester.tap(find.text(prompt));
    await tester.pump();
    expect(find.widgetWithText(TextField, prompt), findsOneWidget);

    await tester.tap(find.text('New chat'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(TextField, prompt), findsNothing);
    expect(find.text('History'), findsOneWidget);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(VisualYouNavigationBar), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    await database.close();
  });
}
