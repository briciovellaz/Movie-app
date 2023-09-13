import 'package:bricio_vellaz/src/presentation/widget/movie_card/movie_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock_data.dart';

void main() {
  testWidgets(
    'Header section should have a movie s title and original title ',
    (tester) async {
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: MovieHeader(
            title: mockMovie1.title,
            originalTitle: mockMovie1.originalTitle,
          ),
        ),
      );

      expect(
        find.text(mockMovie1.title),
        findsOneWidget,
      );
      expect(
        find.text(mockMovie1.originalTitle),
        findsOneWidget,
      );
    },
  );
}
