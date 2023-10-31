import 'package:flutter/material.dart';

import '../../domain/entity/movie.dart';
import 'detailed_list_item.dart';

class VerticalMoviesList extends StatelessWidget {
  final List<Movie> movies;
  final ScrollPhysics? physics;

  const VerticalMoviesList({
    super.key,
    required this.movies,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        physics: physics ?? const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return DetailedListItem(
            movie: movies[index],
          );
        },
      );
    }
}
