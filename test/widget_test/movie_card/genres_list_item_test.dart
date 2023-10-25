import 'package:bricio_vellaz/src/domain/entity/genre.dart';
import 'package:bricio_vellaz/src/presentation/widget/movie_card/genres_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUp(() {
    registerFallbackValue(
      Genre(
        id: 1,
        name: 'name',
      ),
    );
    registerFallbackValue(Route);
  });
  testWidgets(
    'Each item of the genres list should be a button with a name',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: GenreListItem(genre: mockGenre),
        ),
      );

      expect(
        find.byType(GenreListItem),
        findsOneWidget,
      );
    },
  );
}
