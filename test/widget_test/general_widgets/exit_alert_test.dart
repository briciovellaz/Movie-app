import 'package:bricio_vellaz/src/core/util/strings.dart';
import 'package:bricio_vellaz/src/presentation/widget/exit_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Exit alert popup should have a title, a body, a button to confirm, and a button to go back',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ExitAlert(),
        ),
      );

      expect(
        find.text(ExitAlert.alertTitle),
        findsOneWidget,
      );
      expect(
        find.text(exitAppText),
        findsOneWidget,
      );
      expect(
        find.byType(TextButton),
        findsNWidgets(2),
      );
    },
  );
}
