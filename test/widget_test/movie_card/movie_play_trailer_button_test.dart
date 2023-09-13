import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_play_trailer_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Play Trailer button should have a title and an icon',
    (tester) async {
      await tester.pumpWidget(
        const Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: PlayTrailerButton(),
          ),
        ),
      );

      expect(
        find.byType(Text),
        findsOneWidget,
      );
      expect(
        find.byType(Icon),
        findsOneWidget,
      );
    },
  );
}
