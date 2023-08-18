import 'package:flutter/material.dart';

class GenresList extends StatelessWidget {
  static const String title = 'Genres';
  static const int titleFlex = 1;
  static const int listFlex = 3;
  static const double genresListVerticalPadding = 20;
  static const double genresListHorizontalPadding = 10;
  static const double genresListHeight = 25;
  final List<String> genresList;

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
                  return _GenreListItem(
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

class _GenreListItem extends StatelessWidget {
  const _GenreListItem({
    required this.genre,
  });

  static const double borderRadius = 18;
  static const double horizontalButtonPadding = 3;

  final String genre;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalButtonPadding,
      ),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          genre,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
