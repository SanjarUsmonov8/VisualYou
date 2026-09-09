import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';
import 'package:visualyou/main.dart';

import 'test_calendar_repository.dart';
import 'test_custom_graph_repository.dart';
import 'test_reduction_calendar_repository.dart';

void main() {
  testWidgets('habit-management cards do not overflow on a small phone', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(320, 568));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final database = AppDatabase(NativeDatabase.memory());
    final repository = DriftHabitRepository(database);
    final rewardsRepository = RewardsRepository(database);
    await repository.initialize();
    await rewardsRepository.initialize();
    await rewardsRepository.setPlan(MembershipPlan.plus);

    await tester.pumpWidget(
      VisualYouApp(
        skipOnboarding: true,
        habitRepository: repository,
        customGraphRepository: const TestCustomGraphRepository(),
        calendarRepository: const TestCalendarRepository(),
        reductionCalendarRepository: const TestReductionCalendarRepository(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('addHabitButton')));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Edit habits'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);

    await tester.tap(find.byTooltip('Finish editing'));
    await repository.setHabitNumericalTracking(
      'water',
      enabled: true,
      target: 8,
    );
    await tester.pumpAndSettle();

    expect(find.byType(ListWheelScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pumpAndSettle();
    await database.close();
  });
}
