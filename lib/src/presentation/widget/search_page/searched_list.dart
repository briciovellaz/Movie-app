import 'package:flutter/material.dart';

import '../../../domain/entity/movie.dart';
import 'no_match.dart';
import 'search_list_item.dart';

//FIXME to be correctly implemented on future modules

class SearchedList extends StatelessWidget {
  final List<Movie> movies;
  final String toSearch;

  const SearchedList({
    super.key,
    required this.toSearch,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    if (toSearch.isNotEmpty) {
      final List<Movie> filteredMovies = movies
          .where(
            (movie) =>
                movie.title.toUpperCase().contains(toSearch.toUpperCase()),
          )
          .toList();
      if (filteredMovies.isEmpty) {
        return const NoMatchAlert();
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredMovies.length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return SearchListItem(
            movie: filteredMovies[index],
          );
        },
      );
    }
    return const NoMatchAlert();
  }
}
