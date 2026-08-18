import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/main.dart';

void main() {
  testWidgets('first welcome page shows its content and only a next action', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    var finished = false;
    final themeController = ThemeController();
    themeController.updateProfile(
      name: 'Alex',
      birthDate: DateTime(2000, 6, 15),
    );
    addTearDown(themeController.dispose);
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeFlow(
          themeController: themeController,
          onFinished: () async => finished = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('Visual You'), findsOneWidget);
    expect(find.text('English (English)'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);
    expect(find.text('Previous'), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(find.text('Body'), findsOneWidget);
    expect(find.text('Progress'), findsOneWidget);
    expect(find.text('Previous'), findsOneWidget);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(find.text('Gradual'), findsOneWidget);
    expect(find.text('Reduction'), findsOneWidget);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(find.text('Custom'), findsOneWidget);
    expect(find.text('Graph'), findsOneWidget);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(find.text('More'), findsOneWidget);
    expect(find.text('Features'), findsOneWidget);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Sign up with email'), findsOneWidget);
    expect(find.text('Continue with Google'), findsOneWidget);
    expect(find.text('Continue with Apple'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    await tester.tap(find.text('Sign up with email'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('signupEmailField')), findsOneWidget);
    Navigator.of(
      tester.element(find.byKey(const Key('signupEmailField'))),
    ).pop();
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    expect(find.text('Almost done'), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Light'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
    expect(find.text('Blue'), findsOneWidget);
    expect(find.text('Pink'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('welcomeProfileName')),
      'Taylor',
    );
    await tester.pump();
    expect(themeController.profileName, 'Taylor');

    themeController.setMode(ThemeMode.dark);
    await tester.pump();
    expect(
      Theme.of(
        tester.element(find.byKey(const Key('welcomeProfileName'))),
      ).brightness,
      Brightness.dark,
    );

    await tester.tap(find.text('Previous'));
    await tester.pumpAndSettle();
    expect(find.text('Create Account'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.text('Create Account'))).brightness,
      Brightness.light,
    );

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();

    expect(find.text('What are your habits?'), findsOneWidget);
    expect(find.text('Drinking water'), findsOneWidget);
    expect(find.text('Studying'), findsOneWidget);
    expect(find.text('Consuming sugar'), findsOneWidget);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pumpAndSettle();

    expect(finished, isFalse);
    expect(find.text('Before you begin'), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);
    expect(themeController.termsAccepted, isFalse);

    await tester.ensureVisible(find.byKey(const Key('honestyAgreementNote')));
    await tester.tap(find.byKey(const Key('honestyAgreementNote')));
    await tester.pump();
    expect(themeController.termsAccepted, isFalse);

    await tester.ensureVisible(find.byKey(const Key('symbolicAgreementNote')));
    await tester.tap(find.byKey(const Key('symbolicAgreementNote')));
    await tester.pump();
    expect(themeController.termsAccepted, isTrue);

    await tester.ensureVisible(find.byKey(const Key('allTermsAgreement')));
    await tester.tap(find.byKey(const Key('allTermsAgreement')));
    await tester.pump();
    expect(themeController.termsAccepted, isFalse);
    await tester.tap(find.byKey(const Key('allTermsAgreement')));
    await tester.pump();
    expect(themeController.termsAccepted, isTrue);

    await tester.tap(find.byKey(const Key('welcomeNextButton')));
    await tester.pump();
    expect(finished, isTrue);
  });

  testWidgets('settings can preview and close welcome pages', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    final themeController = ThemeController();
    addTearDown(themeController.dispose);
    await tester.pumpWidget(
      MaterialApp(home: SettingsPage(themeController: themeController)),
    );
    await tester.pumpAndSettle();

    final previewButton = find.byKey(const Key('previewWelcomePagesButton'));
    await tester.scrollUntilVisible(
      previewButton,
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(previewButton);
    await tester.pumpAndSettle();

    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.byKey(const Key('closeWelcomePreviewButton')), findsOneWidget);

    await tester.tap(find.byKey(const Key('closeWelcomePreviewButton')));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
  });
}
