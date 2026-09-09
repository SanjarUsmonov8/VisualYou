import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/features/body/body.dart';
import 'package:visualyou/features/female_body/female_body.dart';

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

  testWidgets('male muscle card switches between front and back layers', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() {
      tester.binding.setSurfaceSize(null);
      BodyVisualState.showOrgans();
      BodyVisualState.showMuscleFront();
    });

    BodyVisualState.showMuscles();
    BodyVisualState.showMuscleFront();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: BodyFrame())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Front'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName.endsWith('mhead2.png'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName.endsWith('mback.png'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('female muscle card uses the female back layers', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() {
      tester.binding.setSurfaceSize(null);
      BodyVisualState.showOrgans();
      BodyVisualState.showMuscleFront();
    });

    BodyVisualState.showMuscles();
    BodyVisualState.showMuscleBack();
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: FemaleBodyFrame())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Front'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName.endsWith('fback.png'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('locked back view shows a blurred Plus upgrade preview', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() {
      tester.binding.setSurfaceSize(null);
      BodyVisualState.showOrgans();
      BodyVisualState.showMuscleFront();
    });

    BodyVisualState.showMuscles();
    BodyVisualState.showMuscleFront();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: BodyFrame(
              backViewLocked: true,
              onUpgradeBack: () {},
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Back'));
    await tester.pumpAndSettle();

    expect(find.text('Upgrade to Plus to unlock'), findsOneWidget);
    expect(find.text('Upgrade to Plus'), findsOneWidget);
    expect(find.byType(ImageFiltered), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
