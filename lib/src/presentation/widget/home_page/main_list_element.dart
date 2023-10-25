import 'package:flutter/material.dart';

import '../../../config/routes/animated_route.dart';
import '../../../domain/entity/movie.dart';
import '../../view/movie_card.dart';
import '../cached_image.dart';

class MainListElement extends StatelessWidget {
  final Movie movie;

  const MainListElement({
    super.key,
    required this.movie,
  });

  static const double containerHeight = 600;
  static const double containerWidth = 400;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: containerHeight,
      width: containerWidth,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            animatedRoute(MovieCard(movie: movie)),
          );
        },
        child: CachedImage(
          imageUrl: movie.poster,
        ),
      ),
    );
  }
}
