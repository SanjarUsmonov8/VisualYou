import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/rewards/premium_page.dart';
import 'package:visualyou/features/rewards/rewards_controller.dart';
import 'package:visualyou/features/rewards/rewards_models.dart';
import 'package:visualyou/features/rewards/rewards_repository.dart';

void main() {
  testWidgets(
    'targeted premium navigation places the requested plan near top',
    (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      final database = AppDatabase(NativeDatabase.memory());
      await DriftHabitRepository(database).initialize();
      final controller = RewardsController(RewardsRepository(database));
      await controller.initialize();
      addTearDown(() async {
        tester.binding.setSurfaceSize(null);
        controller.dispose();
        await database.close();
      });

      await tester.pumpWidget(
        MaterialApp(
          home: PremiumPage(
            controller: controller,
            initialPlan: MembershipPlan.ultra,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final ultraTitle = find.text('Ultra').first;
      expect(ultraTitle, findsOneWidget);
      expect(tester.getTopLeft(ultraTitle).dy, lessThan(190));
    },
  );
}
