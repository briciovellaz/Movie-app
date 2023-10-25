import 'package:bricio_vellaz/src/core/parameter/fetch_movies_parameters.dart';
import 'package:bricio_vellaz/src/core/parameter/movie_parameters.dart';
import 'package:bricio_vellaz/src/core/util/data_state.dart';
import 'package:bricio_vellaz/src/core/util/enums.dart';
import 'package:bricio_vellaz/src/data/repository/database_movie_repository.dart';
import 'package:bricio_vellaz/src/data/repository/genres_repository.dart';
import 'package:bricio_vellaz/src/data/repository/movie_repository.dart';
import 'package:bricio_vellaz/src/domain/entity/genre.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:bricio_vellaz/src/domain/usecase/implementation/get_genres_by_id_usecase.dart';
import 'package:bricio_vellaz/src/domain/usecase/implementation/get_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

class MockGenreRepository extends Mock implements GenresRepository {}

class MockDBRepository extends Mock implements MovieDatabaseRepository {}

void main() {
  late MockMovieRepository mockMovieRepo;
  late MockGenreRepository mockGenreRepo;
  late MockDBRepository mockDBRepository;

  Future<DataState<List<Movie>>> mockFutureMovieSuccess =
      Future(() => DataSuccess<List<Movie>>([]));
  Future<DataState<List<Genre>>> mockFutureGenreSuccess =
      Future(() => DataSuccess<List<Genre>>([]));
  Future<DataState<List<Movie>>> mockFutureMovieFailure =
      Future(() => DataFailed('Error'));
  Future<DataState<List<Genre>>> mockFutureGenreFailure =
      Future(() => DataFailed('Error'));

  late GetMoviesUseCase getMoviesUseCase;
  late GetGenresByIdUsecase genresByIdUsecase;

  setUpAll(
    () {
      mockMovieRepo = MockMovieRepository();
      mockGenreRepo = MockGenreRepository();
      mockDBRepository = MockDBRepository();

      getMoviesUseCase = GetMoviesUseCase(
        remoteRepository: mockMovieRepo,
        databaseRepository: mockDBRepository,
      );
      genresByIdUsecase =
          GetGenresByIdUsecase(databaseRepository: mockDBRepository);

      registerFallbackValue(MovieParameters());
      registerFallbackValue(Endpoint.popular);
    },
  );

  group(
    'Use cases success return tests',
    () {
      test(
        'Get movies usecase should return a DataSuccess when the repository call is correct',
        () async {
          when(
            () => mockMovieRepo.getMovies(
              params: any(named: 'params'),
              endpoint: any(named: 'endpoint'),
            ),
          ).thenAnswer((_) => mockFutureMovieSuccess);

          final result = await getMoviesUseCase.call(
            params: FetchMovieParameters(
              params: MovieParameters.list(),
              endpoint: Endpoint.nowPlaying,
            ),
          );

          expect(
            result.state == ElementState.success,
            isTrue,
          );
        },
      );

      test(
        'Get genres by id usecase should return a DataSuccess when the repository call is correct',
        () async {
          when(() => mockGenreRepo.getFromIds(any()))
              .thenAnswer((_) => mockFutureGenreSuccess);

          final result = await genresByIdUsecase.call(
            params: [],
          );

          expect(
            result.state == ElementState.success,
            isTrue,
          );
        },
      );
    },
  );

  group(
    'Use cases failure return tests',
    () {
      test(
        'Get movies usecase should return a DataSuccess when the repository call is correct',
        () async {
          when(
            () => mockMovieRepo.getMovies(
              params: any(named: 'params'),
              endpoint: any(named: 'endpoint'),
            ),
          ).thenAnswer((_) => mockFutureMovieFailure);

          final result = await getMoviesUseCase.call(
            params: FetchMovieParameters(
              params: MovieParameters.list(),
              endpoint: Endpoint.nowPlaying,
            ),
          );

          expect(
            result.state == ElementState.failure,
            isTrue,
          );
        },
      );

      test(
        'Get genres by id usecase should return a DataSuccess when the repository call is correct',
        () async {
          when(() => mockGenreRepo.getFromIds(any()))
              .thenAnswer((_) => mockFutureGenreFailure);

          final result = await genresByIdUsecase.call(
            params: [],
          );

          expect(
            result.state == ElementState.failure,
            isTrue,
          );
        },
      );
    },
  );
}
