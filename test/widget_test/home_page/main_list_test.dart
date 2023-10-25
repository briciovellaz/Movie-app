import 'package:bricio_vellaz/src/core/util/constants.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:bricio_vellaz/src/domain/entity/movie_category.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/main_elements_list.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/main_list_element.dart';
import 'package:bricio_vellaz/src/presentation/widget/show_all_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  group(
    'Main movies list tests',
    () {
      testWidgets(
          'Main list should display only one item at a time, even if there are more',
          (tester) async {
        await tester.pumpWidget(
          Material(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: MainElementsList(
                listInfo: MovieCategory(
                  movies: List<Movie>.generate(3, (index) => mockMovie1),
                  name: 'movies',
                ),
              ),
            ),
          ),
        );

        expect(
          find.byType(MainListElement),
          findsOneWidget,
        );
      });

      testWidgets(
        'Main movies list should display a button to show all movies if a certain limit is exceeded',
        (tester) async {
          await tester.pumpWidget(
            Material(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MainElementsList(
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
