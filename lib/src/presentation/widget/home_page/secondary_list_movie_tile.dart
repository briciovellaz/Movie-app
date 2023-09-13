import 'package:flutter/material.dart';

import '../../../config/routes/animated_route.dart';
import '../../../core/util/constants.dart' as constants;
import '../../../domain/entity/movie.dart';
import '../../view/movie_card.dart';
import '../cached_image.dart';
import '../custom_gradient.dart';

class SecondaryListMovieTile extends StatelessWidget {
  const SecondaryListMovieTile({
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
                animatedRoute(MovieCard(movie: movie)),
              );
            },
            child: SizedBox(
              child: Stack(
                children: [
                  CachedImage(
                    imageUrl: movie.backdrop,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      gradient: customGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(constants.mainPadding),
                      child: Text(
                        movie.title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
