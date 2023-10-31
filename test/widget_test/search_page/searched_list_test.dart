import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:bricio_vellaz/src/presentation/widget/detailed_list_item.dart';
import 'package:bricio_vellaz/src/presentation/widget/vertical_movies_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  late List<Movie> mockSearch;

  setUp(() {
    mockSearch = [mockMovie1, mockMovie1, mockMovie1];
  });

  testWidgets(
    'List of searched items should display the correct results',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: VerticalMoviesList(movies: mockSearch),
          ),
        ),
      );

      expect(
        find.byType(DetailedListItem),
        findsNWidgets(3),
      );
    },
  );
}
