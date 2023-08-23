
import 'package:flutter/material.dart';

import '../cached_image.dart';
import '../movie.dart';
import '../movie_card_route.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    super.key,
    required this.movie,
  });

  static const double listItemPadding = 10;
  static const double borderRadius = 30;
  static const double containerHeight = 200;
  static const double containerWidth = 200;

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
            child: CachedImage(
              imageUrl: movie.poster,
            ),
          ),
        ),
      ),
    );
  }
}
