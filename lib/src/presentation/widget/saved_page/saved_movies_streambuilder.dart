import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/parameter/movie_parameters.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/strings.dart';
import '../../../domain/entity/event/implementation/movie_event.dart';
import '../../../domain/entity/movie.dart';
import '../../bloc/movies_bloc.dart';
import '../vertical_movies_list.dart';

class SavedMoviesStreamBuilder extends StatefulWidget {
  final Endpoint endpoint;

  const SavedMoviesStreamBuilder({
    super.key,
    required this.endpoint,
  });

  @override
  State<SavedMoviesStreamBuilder> createState() =>
      _SavedMoviesStreamBuilderState();
}

class _SavedMoviesStreamBuilderState extends State<SavedMoviesStreamBuilder> {

  String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    MoviesBloc bloc = Provider.of<MoviesBloc>(context);
    bloc.fetchMovies(
      params: MovieParameters.list(),
      endpoint: widget.endpoint,
    );
    late final Stream<MovieEvent> stream;
    switch (widget.endpoint) {
      case Endpoint.favorites:
        emptyMessage = 'No favorites movies';
        stream = bloc.favoritesMovies;
        break;
      case Endpoint.watchlist:
        emptyMessage = 'No movies in watchlist';
        stream = bloc.watchlist;
        break;
      default:
        return const Text(noDataErrorText);
    }
    return StreamBuilder<MovieEvent>(
      stream: stream,
      initialData: MovieEvent.loading(),
      builder: (BuildContext context, AsyncSnapshot<MovieEvent> snapshot) {
        {
          switch (snapshot.data!.state) {
            case ElementState.success:
              var snapshotData = snapshot.data?.data as List<Movie>;
              return VerticalMoviesList(movies: snapshotData);
            case ElementState.empty:
              return Center(child: Text(emptyMessage!));
            case ElementState.failure:
              return Text(snapshot.data!.error!);
            case ElementState.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        }
      },
    );
  }

}
