import 'package:flutter/material.dart';

import '../../../domain/entity/movie.dart';
import '../detailed_list_item.dart';

class SearchedList extends StatelessWidget {
  final List<Movie> movies;

  const SearchedList({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
