import 'package:bricio_vellaz/movie.dart';
import 'package:bricio_vellaz/movie_card.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MovieCard(
      movie: Movie.marioExample(),
    );
  }
}
