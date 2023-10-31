import 'dart:async';

import '../../core/bloc/movies_bloc_interface.dart';
import '../../core/parameter/fetch_movies_parameters.dart';
import '../../core/parameter/movie_parameters.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart';
import '../../domain/entity/event/implementation/movie_event.dart';
import '../../domain/entity/movie.dart';
import '../../domain/usecase/implementation/get_movies_usecase.dart';

class MoviesBloc implements IMoviesBloc<MovieParameters> {
  final GetMoviesUseCase usecase;

  final _nowPlayingController = StreamController<MovieEvent>.broadcast();
  final _upcomingController = StreamController<MovieEvent>.broadcast();
  final _popularController = StreamController<MovieEvent>.broadcast();
  final _topRatedController = StreamController<MovieEvent>.broadcast();
  final _recommendedMoviesController = StreamController<MovieEvent>.broadcast();
  final _auxiliaryController = StreamController<MovieEvent>.broadcast();
  final _similarMoviesController = StreamController<MovieEvent>.broadcast();
  final _searchedMoviesController = StreamController<MovieEvent>.broadcast();
  final _moviesByGenreController = StreamController<MovieEvent>.broadcast();
  final _favoritesMoviesController = StreamController<MovieEvent>.broadcast();
  final _watchlistController = StreamController<MovieEvent>.broadcast();

  Stream<MovieEvent> get nowPlayingStream => _nowPlayingController.stream;
  Stream<MovieEvent> get upcomingStream => _upcomingController.stream;
  Stream<MovieEvent> get popularStream => _popularController.stream;
  Stream<MovieEvent> get topRatedStream => _topRatedController.stream;
  Stream<MovieEvent> get auxiliaryStream => _auxiliaryController.stream;
  Stream<MovieEvent> get recommendedMovies =>
      _recommendedMoviesController.stream;
  Stream<MovieEvent> get similarMovies => _similarMoviesController.stream;
  Stream<MovieEvent> get filteredMovies => _searchedMoviesController.stream;
  Stream<MovieEvent> get moviesByGenre => _moviesByGenreController.stream;
  Stream<MovieEvent> get favoritesMovies => _favoritesMoviesController.stream;
  Stream<MovieEvent> get watchlist => _watchlistController.stream;

  Stream<MovieEvent> getStreamFromEndpoint({required Endpoint endpoint}) {
    late Stream<MovieEvent> result;
    switch (endpoint) {
      case Endpoint.nowPlaying:
        result = nowPlayingStream;
      case Endpoint.upcoming:
        result = upcomingStream;
      case Endpoint.popular:
        result = popularStream;
      case Endpoint.topRated:
        result = topRatedStream;
      default:
        _auxiliaryController.sink
            .add(MovieEvent.failure(error: noDataErrorText));
        result = auxiliaryStream;
        break;
    }
    return result;
  }

  Stream<MovieEvent> getStreamFromCategory({required HomeCategory category}) {
    late final Stream<MovieEvent> result;
    switch (category) {
      case HomeCategory.main:
        result = nowPlayingStream;
      case HomeCategory.secondary:
        result = upcomingStream;
      default:
        _auxiliaryController.sink
            .add(MovieEvent.failure(error: noDataErrorText));
        result = auxiliaryStream;
        break;
    }
    return result;
  }

  MoviesBloc({
    required this.usecase,
  });

  @override
  void initialize() {}

  @override
  void fetchMovies({
    MovieParameters? params,
    int? id,
    required Endpoint endpoint,
  }) async {
    StreamController<MovieEvent> controller;
    switch (endpoint) {
      case Endpoint.nowPlaying:
        controller = _nowPlayingController;
        break;
      case Endpoint.upcoming:
        controller = _upcomingController;
        break;
      case Endpoint.popular:
        controller = _popularController;
        break;
      case Endpoint.topRated:
        controller = _topRatedController;
        break;
      case Endpoint.recommended:
        controller = _recommendedMoviesController;
        break;
      case Endpoint.similar:
        controller = _similarMoviesController;
        break;
      case Endpoint.search:
        controller = _searchedMoviesController;
        break;
      case Endpoint.discover:
        controller = _moviesByGenreController;
        break;
      case Endpoint.favorites:
        controller = _favoritesMoviesController;
        break;
      case Endpoint.watchlist:
        controller = _watchlistController;
        break;
    }
    _sendEventToController(
      dataState: await usecase.call(
        params: FetchMovieParameters(
          endpoint: endpoint,
          params: params!,
          id: id,
        ),
      ),
      controller: controller,
    );
  }

  void _sendEventToController({
    required DataState<List<Movie>> dataState,
    required StreamController<MovieEvent> controller,
  }) {
    controller.sink.add(MovieEvent.loading());
    if (dataState.state == ElementState.success) {
      (dataState.data!.isNotEmpty)
          ? controller.sink.add(MovieEvent.success(movies: dataState.data!))
          : controller.sink.add(MovieEvent.empty());
    } else if (dataState.state == ElementState.failure) {
      controller.sink.add(MovieEvent.failure(error: apiErrorMessage));
    }
  }

  @override
  void dispose() {
    _nowPlayingController.close();
    _upcomingController.close();
    _popularController.close();
    _topRatedController.close();
    _auxiliaryController.close();
    _recommendedMoviesController.close();
    _similarMoviesController.close();
    _searchedMoviesController.close();
    _moviesByGenreController.close();
    _watchlistController.close();
    _favoritesMoviesController.close();
  }
}
