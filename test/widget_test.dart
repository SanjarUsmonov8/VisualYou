// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:visualyou/main.dart';

void main() {
  testWidgets('home actions navigate to profile and settings', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const VisualYouApp());

    expect(find.text("Let's build a better you"), findsOneWidget);
    expect(find.text('Quick add'), findsOneWidget);
    expect(find.text('Water'), findsOneWidget);
    expect(find.byType(VisualYouNavigationBar), findsOneWidget);
    expect(find.byType(AnatomyIcon), findsNWidgets(2));

    await tester.tap(find.byTooltip('Body statistics'));
    await tester.pumpAndSettle();
    expect(find.text('Body statistics'), findsOneWidget);

    await tester.tap(find.byTooltip('Home'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('addHabitButton')));
    await tester.pump(const Duration(milliseconds: 100));
    final reveal = tester.widget<ClipPath>(find.byType(ClipPath).last);
    expect(reveal.clipper, isNotNull);
    await tester.pumpAndSettle();
    expect(find.text('Add a habit'), findsOneWidget);
    expect(find.text('Good habits'), findsOneWidget);
    expect(find.text('Drinking water'), findsOneWidget);
    expect(find.text('Exercises'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Bad habits'), 300);
    expect(find.text('Bad habits'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('profileButton')));
    await tester.pumpAndSettle();
    expect(find.text('Profile'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settingsButton')));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
    expect(find.byIcon(Icons.light_mode_rounded), findsOneWidget);
    expect(find.byIcon(Icons.brightness_auto_rounded), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode_rounded), findsOneWidget);
    expect(find.text('Blue'), findsOneWidget);
    expect(find.text('Pink'), findsOneWidget);

    await tester.tap(find.text('Light'));
    await tester.pumpAndSettle();
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.light,
    );

    final bluePrimary = tester
        .widget<MaterialApp>(find.byType(MaterialApp))
        .theme!
        .colorScheme
        .primary;
    await tester.tap(find.text('Pink'));
    await tester.pumpAndSettle();
    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.theme!.colorScheme.primary, isNot(bluePrimary));
  });
}
