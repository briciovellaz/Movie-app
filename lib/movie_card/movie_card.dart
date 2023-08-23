import 'package:flutter/material.dart';

import '../cached_image.dart';
import '../constants/constants.dart' as constants;
import '../constants/strings.dart' as strings;
import '../genre.dart';
import '../genres_repository.dart';
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
  late final Future<List<Genre>> genresList =
      GenresRepository().getFromIds(widget.movie.genres);

  void _incrementCounter() {
    setState(
      () {
        widget.movie.incrementVoteCount();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: constants.appBarElevation,
          backgroundColor: Colors.transparent,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
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
                  CachedImage(
                    imageUrl: widget.movie.backdrop,
                  ),
                  MovieHeader(
                    title: widget.movie.title,
                    originalTitle: widget.movie.originalTitle,
                  ),
                  MovieActions(
                    movie: widget.movie,
                  ),
                  FutureBuilder(
                    future: genresList,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Genre>> snapshot,
                    ) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (snapshot.hasData) {
                        var genres = snapshot.data as List<Genre>;
                        return GenresList(
                          genresList: genres,
                        );
                      }
                      return const Text(strings.noDataErrorText);
                    },
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
      ),
    );
  }
}
