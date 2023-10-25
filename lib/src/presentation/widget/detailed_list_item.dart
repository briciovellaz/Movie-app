import 'package:flutter/material.dart';

import '../../config/routes/animated_route.dart';
import '../../core/util/constants.dart' as constants;
import '../../domain/entity/movie.dart';
import '../view/movie_card.dart';
import 'cached_image.dart';
import 'detailed_list_item_info.dart';

class DetailedListItem extends StatelessWidget {
  const DetailedListItem({
    super.key,
    required this.movie,
  });

  static const double verticalPadding = 8.0;
  static const double borderRadius = 8.0;
  static const double cardHeight = 150;
  static const int infoFlex = 3;

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          animatedRoute(MovieCard(movie: movie)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: verticalPadding),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.tertiary),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.all(constants.mainPadding),
          height: cardHeight,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: constants.mainPadding,
                ),
                child: CachedImage(
                  imageUrl: movie.poster,
                ),
              ),
              Expanded(
                //key: const Key('detailInfo'),
                flex: infoFlex,
                child: DetailedTileInfo(movie: movie),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
