import 'package:bricio_vellaz/src/core/util/constants.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:bricio_vellaz/src/domain/entity/movie_category.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/home_page_movie_tile.dart';
import 'package:bricio_vellaz/src/presentation/widget/horizontal_movies_list.dart';
import 'package:bricio_vellaz/src/presentation/widget/show_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  MovieCategory mockCategory =
      MovieCategory(movies: [mockMovie1, mockMovie1], name: 'movies');

  group(
    'Horizontal movies list Tests',
    () {
      testWidgets(
        'Movie list should have a title and a button to show all movies',
        (tester) async {
          await tester.pumpWidget(
            Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MoviesList(category: mockCategory),
              ),
            ),
          );
          expect(
            find.text(mockCategory.name),
            findsOneWidget,
          );
          expect(
            find.byType(IconButton),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Movie list should display the correct amount of movies',
        (tester) async {
          await tester.pumpWidget(
            Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MoviesList(category: mockCategory),
              ),
            ),
          );

          expect(
            find.byType(MovieTile),
            findsNWidgets(2),
          );
        },
      );

      testWidgets(
        'Movie list should add a button to show all movies if a certain limit is exceeded',
        (tester) async {
          await tester.pumpWidget(
            Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MoviesList(
                  category: MovieCategory(
                    movies: List<Movie>.generate(
                      homeMaxElementsPerList + 1,
                      (i) => mockMovie1,
                    ),
                    name: 'category',
                  ),
                ),
              ),
            ),
          );

          await tester.scrollUntilVisible(
            find.byType(ShowAllButton),
            500.0,
            scrollable: find.byType(Scrollable),
          );

          expect(
            find.byType(ShowAllButton),
            findsOneWidget,
          );
        },
      );
    },
  );
}
