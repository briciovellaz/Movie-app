import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Action button should be an icon button',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SecondaryButton(
              icon: Icons.bookmark,
              onPressed: () {},
            ),
          ),
        ),
      );
      expect(
        find.byType(IconButton),
        findsOneWidget,
      );
    },
  );
}
