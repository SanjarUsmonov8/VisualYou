import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visualyou/widgets/sheet_dismiss_handle.dart';

void main() {
  testWidgets('downward swipe on the visible handle closes its sheet', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => FilledButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                builder: (_) => const SizedBox(
                  height: 300,
                  child: SheetDismissHandle(key: Key('sheetHandle')),
                ),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sheetHandle')), findsOneWidget);

    await tester.drag(find.byKey(const Key('sheetHandle')), const Offset(0, 70));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sheetHandle')), findsNothing);
  });
}
