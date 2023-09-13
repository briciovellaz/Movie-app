import 'dart:convert';
import 'dart:io';

import 'package:bricio_vellaz/src/core/parameter/movie_parameters.dart';
import 'package:bricio_vellaz/src/core/util/data_state.dart';
import 'package:bricio_vellaz/src/core/util/enums.dart';
import 'package:bricio_vellaz/src/data/datasource/remote/genres_service.dart';
import 'package:bricio_vellaz/src/data/datasource/remote/movies_service.dart';
import 'package:bricio_vellaz/src/data/repository/genres_repository.dart';
import 'package:bricio_vellaz/src/data/repository/movie_repository.dart';
import 'package:bricio_vellaz/src/domain/entity/genre.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../mock_data.dart';

class MockGenreService extends Mock implements GenreService {}

class MockMovieService extends Mock implements MovieService {}

void main() {
  late MovieRepository movieRepository;
  late GenresRepository genresRepository;

  const mockGenreJson = mockGenreJSONResponse;
  const mockMovieJson = mockMovieJSONResponse;

  final Response mockFailedResponse = Response(
    '',
    404,
  );
  final Response mockGenreSuccessfulResponse = Response(
    jsonEncode(mockGenreJson),
    200,
  );
  final Response mockMovieSuccessfulResponse = Response(
    jsonEncode(mockMovieJson),
    200,
  );

  late MockGenreService mockGenreService;
  late MockMovieService mockMovieService;

  setUp(
    () {
      mockGenreService = MockGenreService();
      mockMovieService = MockMovieService();
      genresRepository = GenresRepository(genreService: mockGenreService);
      movieRepository = MovieRepository(movieService: mockMovieService);
      registerFallbackValue(MovieParameters());
      registerFallbackValue(Endpoint.popular);
    },
  );

  group(
    'Movie repository tests',
    () {
      test(
        'When there is a problem with the api call, the repository should return a failed data state',
        () async {
          DataState dataState =
              await movieRepository.handleResponse(mockFailedResponse);
          expect(
            dataState.state == ElementState.failure,
            isTrue,
          );
        },
      );
      test(
        'When the api call is successful, the repository should return a success data state with a list of movies',
        () async {
          when(
            () => mockMovieService.getMoviesList(
              any(),
              category: any(named: 'category'),
            ),
          ).thenAnswer(
            (_) => Future(() => mockMovieSuccessfulResponse),
          );

          expect(
            await movieRepository.getMovies(
              params: MovieParameters(),
              endpoint: Endpoint.popular,
            ),
            isInstanceOf<DataSuccess<List<Movie>>>(),
          );
        },
      );
      test(
        'The repository should ignore json results which contains fields with null value',
        () async {
          DataState<List<Movie>> movies =
              await movieRepository.handleResponse(mockMovieSuccessfulResponse);

          expect(
            movies.data!.isEmpty,
            false,
          );

          final Response mockMovieSuccessfulResponseWNulls = Response(
            jsonEncode(mockMovieJSONWithNullsResponse),
            HttpStatus.ok,
          );

          movies = await movieRepository
              .handleResponse(mockMovieSuccessfulResponseWNulls);

          expect(
            movies.data!.isEmpty,
            true,
          );
        },
      );
    },
  );

  group(
    'Genre repository tests',
    () {
      test(
        'Genres list should be empty when the repository is initialized',
        () {
          expect(
            genresRepository.hasGenres(),
            isFalse,
          );
        },
      );

      test(
        'If there is a problem with the api call, the repository should return a failed data state',
        () async {
          when(() => mockGenreService.getMoviesGenres()).thenAnswer(
            (_) => Future(() => mockFailedResponse),
          );
          expect(
            await genresRepository.getAll(),
            isInstanceOf<DataFailed>(),
          );
        },
      );

      test(
        'If the api call is successful should return a success data state with a list of genres',
        () async {
          when(() => mockGenreService.getMoviesGenres()).thenAnswer(
            (_) => Future(() => mockGenreSuccessfulResponse),
          );
          expect(
            await genresRepository.getAll(),
            isInstanceOf<DataSuccess<List<Genre>>>(),
          );
        },
      );
    },
  );
}
