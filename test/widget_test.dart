// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/data/habits/drift_habit_repository.dart';
import 'package:visualyou/data/local/app_database.dart';
import 'package:visualyou/features/female_body/female_body.dart';

import 'package:visualyou/main.dart';

void main() {
  testWidgets('home actions navigate to profile and settings', (
    WidgetTester tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    await tester.pumpWidget(
      VisualYouApp(habitRepository: DriftHabitRepository(database)),
    );
    await tester.pumpAndSettle();

    expect(find.text("Let's build a better you"), findsOneWidget);
    expect(find.text('Quick add'), findsOneWidget);
    expect(find.text('Water'), findsOneWidget);
    expect(find.byType(VisualYouNavigationBar), findsOneWidget);
    expect(find.byType(AnatomyIcon), findsOneWidget);

    await tester.tap(find.byTooltip('Body statistics'));
    await tester.pumpAndSettle();
    expect(find.text('Body statistics'), findsOneWidget);

    await tester.tap(find.byTooltip('Home'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('addHabitButton')));
    await tester.pump(const Duration(milliseconds: 100));
    final reveal = tester.widget<ClipPath>(find.byType(ClipPath).last);
    expect(reveal.clipper == null, false);
    await tester.pumpAndSettle();
    expect(find.text('Add a habit'), findsOneWidget);
    expect(find.text('Good habits ✨'), findsOneWidget);
    expect(find.text('Drinking water'), findsOneWidget);
    expect(find.text('Exercises'), findsOneWidget);
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('profileButton')));
    await tester.pumpAndSettle();
    expect(find.text('Your Name'), findsOneWidget);
    expect(find.text('Edit profile'), findsOneWidget);

    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Alex');
    await tester.enterText(find.byType(TextFormField).at(1), '25');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('25'), findsOneWidget);
    expect(tester.takeException(), null);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settingsButton')));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Spanish').last);
    await tester.pumpAndSettle();
    expect(find.text('Ajustes'), findsOneWidget);
    expect(find.text('Idioma'), findsOneWidget);
    expect(find.text('Español'), findsOneWidget);

    await tester.tap(find.text('Español'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Inglés').last);
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -420));
    await tester.pumpAndSettle();
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
    expect(app.theme!.colorScheme.primary == bluePrimary, false);

    await tester.drag(find.byType(ListView), const Offset(0, -420));
    await tester.pumpAndSettle();
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Female'), findsOneWidget);
    await tester.tap(find.text('Female'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(FemaleBodyFrame), findsOneWidget);
  });
}
