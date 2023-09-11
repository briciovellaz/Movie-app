import 'package:flutter/material.dart';
import '../../../domain/entity/genre.dart';
import 'genres_list_item.dart';

class GenresList extends StatelessWidget {
  static const String title = 'Genres';
  static const int titleFlex = 1;
  static const int listFlex = 3;
  static const double genresListVerticalPadding = 20;
  static const double genresListHorizontalPadding = 10;
  static const double genresListHeight = 25;
  final List<Genre> genresList;

  const GenresList({
    super.key,
    required this.genresList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: genresListVerticalPadding,
        horizontal: genresListHorizontalPadding,
      ),
      child: Row(
        children: [
          Expanded(
            flex: titleFlex,
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            flex: listFlex,
            child: SizedBox(
              height: genresListHeight,
              child: ListView.builder(
                itemCount: genresList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return GenreListItem(
                    genre: genresList[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
