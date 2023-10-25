import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/parameter/movie_parameters.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart' as strings;
import '../../domain/entity/event/implementation/movie_event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/entity/movie_category.dart';
import '../bloc/movies_bloc.dart';
import 'expanded_movie_list.dart';

class SimilarMoviesList extends StatefulWidget {
  const SimilarMoviesList({super.key, required this.id});

  final Endpoint similarEndpoint = Endpoint.similar;
  final int id;

  @override
  State<SimilarMoviesList> createState() => _SimilarMoviesListState();
}

class _SimilarMoviesListState extends State<SimilarMoviesList> {
  late final MoviesBloc bloc;


  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<MoviesBloc>(context);
    bloc.fetchMovies(
      params: MovieParameters(),
      id: widget.id,
      endpoint: widget.similarEndpoint,
    );
    return StreamBuilder<MovieEvent>(
      stream: bloc.similarMovies,
      initialData: MovieEvent.loading(),
      builder: (
        BuildContext context,
        AsyncSnapshot<MovieEvent> snapshot,
      ) {
        switch (snapshot.data?.state) {
          case ElementState.success:
            var movies = snapshot.data?.data as List<Movie>;
            return ExpandedList(
              category: MovieCategory(
                movies: movies,
                name: widget.similarEndpoint.title,
              ),
            );
          case ElementState.empty:
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
              ),
              body: const Text(strings.noDataErrorText),
            );
          case ElementState.failure:
            return const Text(strings.apiErrorMessage);
          case ElementState.loading:
            return Scaffold(
              appBar: AppBar(
                leading: const BackButton(),
              ),
              body: const SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          default:
        }
        if (snapshot.hasData) {}
        return const Text(strings.noDataErrorText);
      },
    );
  }
}
