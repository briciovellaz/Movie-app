import 'package:bricio_vellaz/src/domain/entity/genre.dart';
import 'package:bricio_vellaz/src/presentation/widget/movie_card/genres_list.dart';
import 'package:bricio_vellaz/src/presentation/widget/movie_card/genres_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Genres list should display the correct amount of genres',
    (tester) async {
      final genres = <Genre>[
        mockGenre,
        mockGenre,
        mockGenre,
      ];
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: GenresList(genresList: genres),
          ),
        ),
      );

      expect(
        find.text(mockGenre.name),
        findsNWidgets(3),
      );
      expect(
        find.byType(GenreListItem),
        findsNWidgets(3),
      );
    },
  );
}
