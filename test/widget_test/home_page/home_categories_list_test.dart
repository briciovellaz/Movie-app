import 'package:bricio_vellaz/src/domain/entity/movie_category.dart';
import 'package:bricio_vellaz/src/presentation/widget/home_page/home_categories_list.dart';
import 'package:bricio_vellaz/src/presentation/widget/horizontal_movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Categories List should display the correct amount of categories',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: ListView(
              children: [
                CategoriesList(
                  categories: List<MovieCategory>.generate(
                    2,
                    (index) =>
                        MovieCategory(movies: [], name: 'category $index'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      expect(
        find.byType(MoviesList),
        findsNWidgets(2),
      );
    },
  );
}
