import 'package:flutter/material.dart';

import '../cached_image.dart';
import '../movie.dart';
import '../movie_card_route.dart';

class UpcomingMovieTile extends StatelessWidget {
  const UpcomingMovieTile({
    super.key,
    required this.movie,
  });

  static const double borderRadius = 15;
  static const double listItemPadding = 10;
  static const double containerHeight = 300;
  static const double containerWidth = 300;
  static const double imageContainerHeight = 56;
  static const double imageContainerWidth = 56;
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(listItemPadding),
      child: SizedBox(
        height: containerHeight,
        width: containerWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                movieCardRoute(movie),
              );
            },
            child: SizedBox(
              width: imageContainerWidth,
              height: imageContainerHeight,
              child: CachedImage(
                imageUrl: movie.backdrop,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
