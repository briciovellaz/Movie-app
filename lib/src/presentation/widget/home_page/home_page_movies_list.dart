import 'package:flutter/material.dart';

import '../../../core/util/constants.dart' as constants;
import '../../../domain/entity/movie.dart';
import 'home_page_movie_tile.dart';

class MoviesList extends StatelessWidget {
  final List<Movie> movies;
  final String movieListTitle;
  static const int movieListFlex = 3;
  static const double listContainerHeight = 350;

  const MoviesList({
    super.key,
    required this.movies,
    required this.movieListTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(constants.mainPadding),
          child: Text(
            movieListTitle,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        SizedBox(
          height: listContainerHeight,
          child: ListView.builder(
            itemCount: movies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return MovieTile(
                movie: movies[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
