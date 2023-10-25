import 'package:bricio_vellaz/src/core/util/constants.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:bricio_vellaz/src/domain/entity/movie_category.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/secondary_movies_list.dart';
import 'package:bricio_vellaz/src/presentation/widget/show_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  group(
    'Secondary movies list tests',
    () {
      testWidgets(
        'Secondary movies list should have a title and a button to show all movies',
        (tester) async {
          await tester.pumpWidget(
            Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SecondaryMoviesList(
                  listInfo: MovieCategory(movies: [], name: 'category'),
                ),
              ),
            ),
          );

          expect(
            find.text('category'),
            findsOneWidget,
          );
          expect(
            find.byType(IconButton),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Secondary movies list should display a button to show all movies if a certain limit is exceeded',
        (tester) async {
          await tester.pumpWidget(
            Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: SecondaryMoviesList(
                  listInfo: MovieCategory(
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
