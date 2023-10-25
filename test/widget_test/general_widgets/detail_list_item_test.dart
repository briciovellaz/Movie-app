import 'package:bricio_vellaz/src/presentation/widget/cached_image.dart';
import 'package:bricio_vellaz/src/presentation/widget/detailed_list_item.dart';
import 'package:bricio_vellaz/src/presentation/widget/detailed_list_item_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Detail list item should have an image and info',
    (tester) async {
      await tester.pumpWidget(
        Material(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: DetailedListItem(movie: mockMovie1),
          ),
        ),
      );

      expect(
        find.byType(CachedImage),
        findsOneWidget,
      );
      expect(
        find.byType(DetailedTileInfo),
        findsOneWidget,
      );
    },
  );
}
