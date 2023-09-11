import 'package:flutter/material.dart';
import '../genre.dart';

class GenreListItem extends StatelessWidget {
  const GenreListItem({
    super.key,
    required this.genre,
  });

  static const double borderRadius = 18;
  static const double horizontalButtonPadding = 3;

  final Genre genre;

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
          genre.name,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
