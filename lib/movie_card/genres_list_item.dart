part of 'genres_list.dart';

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