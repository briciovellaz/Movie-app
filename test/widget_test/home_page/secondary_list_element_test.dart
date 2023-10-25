import 'package:bricio_vellaz/src/presentation/widget/cached_image.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/secondary_list_movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Secondary movies tiles should be clickable have an image and the movie title',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: SecondaryListMovieTile(movie: mockMovie1),
          ),
        ),
      );

      expect(
        find.byType(InkWell),
        findsOneWidget,
      );
      expect(
        find.text(mockMovie1.title),
        findsOneWidget,
      );
      expect(
        find.byType(CachedImage),
        findsOneWidget,
      );
    },
  );
}
