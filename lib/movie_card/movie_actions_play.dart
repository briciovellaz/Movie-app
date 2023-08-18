part of 'movie_actions.dart';

class _PlayTrailerButton extends StatelessWidget {
  const _PlayTrailerButton();
  static const String buttonText='Play trailer';

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        //Play trailer
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      icon: Icon(
        Icons.play_arrow,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      label: Text(
        buttonText,
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}
