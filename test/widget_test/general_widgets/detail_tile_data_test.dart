import 'package:bricio_vellaz/src/presentation/widget/detailed_tile_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Each info section in the details tile should have an icon and its info',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: InfoDetail(icon: Icons.abc, info: mockMovie1.title),
        ),
      );

      expect(
        find.text(mockMovie1.title),
        findsOneWidget,
      );
      expect(
        find.byType(Icon),
        findsOneWidget,
      );
    },
  );
}
