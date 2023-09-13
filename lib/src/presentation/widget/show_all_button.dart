import 'package:flutter/material.dart';

import '../../config/routes/animated_route.dart';
import '../../domain/entity/movie_category.dart';
import '../view/expanded_movie_list.dart';

class ShowAllButton extends StatelessWidget {
  final MovieCategory category;
  static const String buttonText = 'Show\nall';
  static const double buttonWidth = 150;

  const ShowAllButton({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            animatedRoute(ExpandedList(category: category)),
          );
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward_ios),
            Text(
              buttonText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
