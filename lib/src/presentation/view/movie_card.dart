import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/parameter/movie_parameters.dart';
import '../../core/util/constants.dart' as constants;
import '../../core/util/enums.dart';
import '../../core/util/strings.dart' as strings;
import '../../domain/entity/event/implementation/genre_event.dart';
import '../../domain/entity/event/implementation/movie_event.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_category.dart';
import '../bloc/genres_by_id_bloc.dart';
import '../bloc/movies_bloc.dart';
import '../widget/cached_image.dart';
import '../widget/horizontal_movies_list.dart';
import '../widget/movie_card/genres_list.dart';
import '../widget/movie_card/movie_actions.dart';
import '../widget/movie_card/movie_header.dart';
import '../widget/movie_card/movie_overview.dart';

class MovieCard extends StatefulWidget {
  final Movie movie;
  final Endpoint recommendedMoviesEndpoint = Endpoint.recommended;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  final MoviesBloc bloc = Get.find();
  final GenresByIdBloc genresBloc = GenresByIdBloc();
  static const int mainOverviewContainerFlex = 3;

  @override
  void initState() {
    bloc.fetchMovies(
      params: MovieParameters(),
      id: widget.movie.id,
      endpoint: widget.recommendedMoviesEndpoint,
    );
    genresBloc.fetchGenres(widget.movie.genres);
    super.initState();
  }

  @override
  void dispose() {
    genresBloc.dispose();
    super.dispose();
  }

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
            color: Theme.of(context).colorScheme.onPrimary,
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
                  StreamBuilder<GenreEvent>(
                    stream: genresBloc.genres,
                    initialData: GenreEvent.loading(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<GenreEvent> snapshot,
                    ) {
                      switch (snapshot.data?.state) {
                        case ElementState.success:
                          var genres = snapshot.data?.data as List<Genre>;
                          return GenresList(
                            genresList: genres,
                          );
                        case ElementState.empty:
                          return const Text(strings.noDataErrorText);
                        case ElementState.failure:
                          return const Text(strings.apiErrorMessage);
                        case ElementState.loading:
                          return const Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        default:
                      }
                      return const Text(strings.noDataErrorText);
                    },
                  ),
                  Expanded(
                    key: const Key('movieOverview'),
                    flex: mainOverviewContainerFlex,
                    child: MovieOverview(
                      overview: widget.movie.overview,
                    ),
                  ),
                  StreamBuilder<MovieEvent>(
                    initialData: MovieEvent.loading(),
                    stream: bloc.recommendedMovies,
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<MovieEvent> snapshot,
                    ) {
                      switch (snapshot.data?.state) {
                        case ElementState.success:
                          var recommendedMovies =
                              snapshot.data?.data as List<Movie>;
                          return MoviesList(
                            category: MovieCategory(
                              movies: recommendedMovies,
                              name: widget.recommendedMoviesEndpoint.title,
                            ),
                          );
                        case ElementState.empty:
                          return const Text(strings.noDataErrorText);
                        case ElementState.failure:
                          return const Text(strings.apiErrorMessage);
                        case ElementState.loading:
                          return const Center(
                            child: SizedBox(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        default:
                      }
                      return const Text(strings.noDataErrorText);
                    },
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
