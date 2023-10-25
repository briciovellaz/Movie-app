import 'package:bricio_vellaz/src/presentation/widget/detailed_list_item_info.dart';
import 'package:bricio_vellaz/src/presentation/widget/detailed_tile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Detail list item info should display the movie title, release date and average votes ',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: DetailedTileInfo(movie: mockMovie1),
          ),
        ),
      );

      expect(
        find.text(mockMovie1.title),
        findsOneWidget,
      );
      expect(
        find.byType(InfoDetail),
        findsNWidgets(2),
      );
    },
  );
}
