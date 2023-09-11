import 'package:flutter/material.dart';

import '../cached_image.dart';
import '../../../config/routes/movie_card_route.dart';
import '../../../core/util/constants.dart' as constants;
import '../../../domain/entity/movie.dart';
import 'searched_item_info.dart';

class SearchListItem extends StatelessWidget {
  const SearchListItem({
    super.key,
    required this.movie,
  });

  static const double verticalPadding = 8.0;
  static const double borderRadius = 8.0;
  static const double cardHeight = 150;

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          movieCardRoute(movie),
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
              SearchedItemInfo(movie: movie),
            ],
          ),
        ),
      ),
    );
  }
}
