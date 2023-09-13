import 'package:bricio_vellaz/src/core/util/strings.dart';
import 'package:bricio_vellaz/src/presentation/widget/search_page/no_match.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'The no match text alert should display a text',
    (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: NoMatchAlert(),
        ),
      );
      expect(
        find.text(noMatchingSearch),
        findsOneWidget,
      );
    },
  );
}
