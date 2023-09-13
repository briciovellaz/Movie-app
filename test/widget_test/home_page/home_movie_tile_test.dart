import 'package:bricio_vellaz/src/presentation/widget/cached_image.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/home_page_movie_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Movies tiles should be clickable and should have an image',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: MovieTile(movie: mockMovie1),
          ),
        ),
      );

      expect(
        find.byType(InkWell),
        findsOneWidget,
      );
      expect(
        find.byType(CachedImage),
        findsOneWidget,
      );
    },
  );
}
