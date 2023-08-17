import 'package:bricio_vellaz/movie.dart';
import 'package:bricio_vellaz/movie_card.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: Movie(
          1,
          'The Super Mario Bros. Movie',
          'The Super Mario Bros. Movie',
          ['Animation', 'Family', 'Adventure', 'Fantasy', 'Comedy'],
          'mario_poster',
          'mario_backdrop',
          '2023-04-05',
          '7,8',
          'While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi '
              'are transported down a mysterious pipe and wander into a magical new world. But when the '
              'brothers are separated, Mario embarks on an epic quest to find Luigi.'),
    );
  }
}
