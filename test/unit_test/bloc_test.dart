import 'package:bricio_vellaz/src/core/parameter/fetch_movies_parameters.dart';
import 'package:bricio_vellaz/src/core/parameter/movie_parameters.dart';
import 'package:bricio_vellaz/src/core/util/data_state.dart';
import 'package:bricio_vellaz/src/core/util/enums.dart';
import 'package:bricio_vellaz/src/domain/entity/event/implementation/genre_event.dart';
import 'package:bricio_vellaz/src/domain/entity/event/implementation/movie_event.dart';
import 'package:bricio_vellaz/src/domain/entity/genre.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:bricio_vellaz/src/domain/usecase/implementation/get_genres_by_id_usecase.dart';
import 'package:bricio_vellaz/src/domain/usecase/implementation/get_movies_usecase.dart';
import 'package:bricio_vellaz/src/presentation/bloc/genres_by_id_bloc.dart';
import 'package:bricio_vellaz/src/presentation/bloc/movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockMoviesUsecase extends Mock implements GetMoviesUseCase {}

class MockGenresById extends Mock implements GetGenresByIdUsecase {}

void main() {
  late MockMoviesUsecase moviesUsecase;
  late MockGenresById genresByIdUsecase;

  Future<DataState<List<Movie>>> mockFutureMovieDataSuccess =
      Future(() => DataSuccess<List<Movie>>([mockMovie1]));
  Future<DataState<List<Movie>>> mockFutureMovieDataEmpty =
      Future(() => DataSuccess<List<Movie>>([]));
  Future<DataState<List<Movie>>> mockFutureMovieDataFailed =
      Future(() => DataFailed<List<Movie>>('Error'));
  Future<DataState<List<Genre>>> mockFutureGenreDataSuccess =
      Future(() => DataSuccess<List<Genre>>([mockGenre]));
  Future<DataState<List<Genre>>> mockFutureGenreDataEmpty =
      Future(() => DataSuccess<List<Genre>>([]));
  Future<DataState<List<Genre>>> mockFutureGenreDataFailed =
      Future(() => DataFailed<List<Genre>>('Error'));

  late MoviesBloc mainPageBloc;
  late GenresByIdBloc genresByIdBloc;

  setUp(
    () {
      moviesUsecase = MockMoviesUsecase();
      genresByIdUsecase = MockGenresById();

      mainPageBloc = MoviesBloc(usecase: moviesUsecase);
      genresByIdBloc = GenresByIdBloc(usecase: genresByIdUsecase);

      registerFallbackValue(
        FetchMovieParameters(
          endpoint: Endpoint.popular,
          params: MovieParameters(),
        ),
      );
    },
  );

  tearDown(() {
    mainPageBloc.dispose();
    genresByIdBloc.dispose();
  });

  group(
    'Blocs return types tests',
    () {
      test(
        'Movies BLoC should return a stream of movieEvents',
        () {
          expect(
            mainPageBloc.getStreamFromEndpoint(endpoint: Endpoint.popular),
            isA<Stream<MovieEvent>>(),
          );
        },
      );

      test(
        'Genres by id BLoC should return a stream of GenreEvent',
        () async {
          expect(
            genresByIdBloc.genres,
            isA<Stream<GenreEvent>>(),
          );
        },
      );
    },
  );

  group(
    'Blocs success events tests',
    () {
      test(
        'When successful, movies BLoC fetchMovies method should return a Stream with a success and a list of movies event after a loading state event',
        () async {
          when(
            () => moviesUsecase.call(
              params: any(named: 'params'),
            ),
          ).thenAnswer((_) async => Future(() => mockFutureMovieDataSuccess));

          final expected = [
            MovieEvent.loading(),
            MovieEvent.success(movies: [mockMovie1]),
          ];
          expectLater(
            mainPageBloc.popularStream,
            emitsInOrder(expected),
          );
          mainPageBloc.fetchMovies(
            params: MovieParameters.list(),
            endpoint: Endpoint.popular,
          );
        },
      );

      test(
        'When successful, genres by id BLoC fetchGenres method should return a Stream with a success event and a list of genres after a loading state event',
        () async {
          when(
            () => genresByIdUsecase.call(
              params: any(named: 'params'),
            ),
          ).thenAnswer((_) => mockFutureGenreDataSuccess);

          final expected = [
            GenreEvent.loading(),
            GenreEvent.success(genres: [mockGenre]),
          ];
          expect(
            genresByIdBloc.genres,
            emitsInOrder(expected),
          );
          genresByIdBloc.fetchGenres([1]);
        },
      );
    },
  );

  group(
    'Blocs failure events tests',
    () {
      test(
        'When unsuccessful, movies BLoC fetchMovies method should return a Stream with a success and a list of movies event after a loading state event',
        () async {
          when(
            () => moviesUsecase.call(
              params: any(named: 'params'),
            ),
          ).thenAnswer((_) async => Future(() => mockFutureMovieDataFailed));

          final expected = [
            MovieEvent.loading(),
            MovieEvent.failure(error: 'error'),
          ];
          expectLater(
            mainPageBloc.popularStream,
            emitsInOrder(expected),
          );
          mainPageBloc.fetchMovies(
            params: MovieParameters.list(),
            endpoint: Endpoint.popular,
          );
        },
      );

      test(
        'When unsuccessful, genres by id BLoC fetchGenres method should return a Stream with a success event and a list of genres after a loading state event',
        () async {
          when(
            () => genresByIdUsecase.call(
              params: any(named: 'params'),
            ),
          ).thenAnswer((_) => mockFutureGenreDataFailed);

          final expected = [
            GenreEvent.loading(),
            GenreEvent.failure(error: 'error'),
          ];
          expect(
            genresByIdBloc.genres,
            emitsInOrder(expected),
          );
          genresByIdBloc.fetchGenres([1]);
        },
      );
    },
  );

  group(
    'Blocs empty events tests',
    () {
      test(
        'When data is empty, main page elements BLoC fetchMovies method should return a Stream with an empty state event after a loading state event',
        () async {
          when(
            () => moviesUsecase.call(
              params: any(named: 'params'),
            ),
          ).thenAnswer(
            (_) async => Future(() => mockFutureMovieDataEmpty),
          );

          final expected = [
            MovieEvent.loading(),
            MovieEvent.empty(),
          ];
          expectLater(
            mainPageBloc.popularStream,
            emitsInOrder(expected),
          );
          mainPageBloc.fetchMovies(
            params: MovieParameters.list(),
            endpoint: Endpoint.popular,
          );
        },
      );

      test(
        'When data is empty, genres by id BLoC fetchGenres method should return a Stream with an empty state event after a loading state event',
        () async {
          when(
            () => genresByIdUsecase.call(
              params: any(named: 'params'),
            ),
          ).thenAnswer((_) => mockFutureGenreDataEmpty);

          final expected = [
            GenreEvent.loading(),
            GenreEvent.empty(),
          ];
          expect(
            genresByIdBloc.genres,
            emitsInOrder(expected),
          );
          genresByIdBloc.fetchGenres([1]);
        },
      );
    },
  );
}
