import 'package:bricio_vellaz/movie.dart';
import 'package:flutter/widgets.dart';
import 'movie_card/movie_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: Movie.marioExample(),
    );
  }
}
