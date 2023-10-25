import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_actions.dart';
import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_like_counter.dart';
import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_play_trailer_button.dart';
import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Movie card actions section should have 3 actions buttons, 1 play trailer button, release date info, and likes data',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MovieActions(movie: mockMovie1),
          ),
        ),
      );

      expect(
        find.byType(PlayTrailerButton),
        findsOneWidget,
      );
      expect(
        find.byType(SecondaryButton),
        findsNWidgets(3),
      );
      expect(
        find.byType(LikeCounter),
        findsOneWidget,
      );
      expect(
        find.text(mockMovie1.releaseDate),
        findsOneWidget,
      );
    },
  );
}
