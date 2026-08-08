import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/features/body/body.dart';

void main() {
  testWidgets('organ and muscle color changes animate', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() {
      tester.binding.setSurfaceSize(null);
      BodyVisualState.brainTint.value = null;
      BodyVisualState.muscleWorkoutCounts.value = const {};
      BodyVisualState.showOrgans();
    });

    BodyVisualState.brainTint.value = null;
    BodyVisualState.muscleWorkoutCounts.value = const {};
    BodyVisualState.showOrgans();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: BodyFrame())),
      ),
    );
    await tester.pumpAndSettle();

    BodyVisualState.brainTint.value = const Color(0xFFE53935);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    BodyVisualState.showMuscles();
    await tester.pumpAndSettle();
    BodyVisualState.muscleWorkoutCounts.value = const {MuscleGroup.arms: 1};
    await tester.pump();
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    await tester.pump(const Duration(milliseconds: 500));
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}
