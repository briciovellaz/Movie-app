import 'package:flutter/material.dart';
import '../movie.dart';
import 'genres_list.dart';
import 'movie_actions.dart';
import 'movie_header.dart';
import 'movie_overview.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  int _counter = 0;
  static const double appBarElevation = 0;

  void _incrementCounter() {
    setState(
      () {
        _counter++;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var image = 'assets/images/${widget.movie.backdrop}.jpg';

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: appBarElevation,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            //go back
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    image,
                  ),
                ),
                MovieHeader(
                  title: widget.movie.title,
                  originalTitle: widget.movie.originalTitle,
                ),
                MovieActions(
                  movie: widget.movie,
                  counter: _counter,
                ),
                GenresList(
                  genresList: widget.movie.genres,
                ),
                MovieOverview(
                  overview: widget.movie.overview,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter();
        },
        child: const Icon(
          Icons.thumb_up_alt_sharp,
        ),
      ),
    );
  }
}
