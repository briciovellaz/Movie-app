import 'package:bricio_vellaz/src/data/datasource/local/DAOs/genre_dao.dart';
import 'package:bricio_vellaz/src/data/datasource/local/DAOs/movie_category_dao.dart';
import 'package:bricio_vellaz/src/data/datasource/local/DAOs/movie_dao.dart';
import 'package:bricio_vellaz/src/data/datasource/local/DAOs/related_movie_dao.dart';
import 'package:bricio_vellaz/src/data/datasource/local/movie_database.dart';
import 'package:bricio_vellaz/src/domain/entity/database/movie_category.dart';
import 'package:bricio_vellaz/src/domain/entity/database/related_movie.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock_data.dart';

void main() {
  late MovieDatabase database;
  late MovieDAO movieDAO;
  late GenreDAO genreDAO;
  late MovieCategoryDAO categoryDAO;
  late RelatedMovieDAO relatedMovieDAO;

  setUp(() async {
    database = await $FloorMovieDatabase.inMemoryDatabaseBuilder().build();
    movieDAO = database.movieDAO;
    genreDAO = database.genreDAO;
    categoryDAO = database.movieCategoryDAO;
    relatedMovieDAO = database.relatedMovieDAO;

    movieDAO.insertMovie(mockMovie1);
    movieDAO.insertMovie(mockMovie2);
    genreDAO.insertGenre(mockGenre);
    categoryDAO.insertMovieCategory(
      MovieCategory(
        movieId: mockMovie1.id,
        category: 'Category',
      ),
    );
    relatedMovieDAO.insertRelation(
      RelatedMovie(
        movieId: mockMovie1.id,
        relatedMovieId: mockMovie2.id,
        relation: 'Related',
      ),
    );
  });

  tearDown(() async {
    database.close();
  });

  group('Movies fetch tests', () {
    test('Get by category test', () async {
      final result = await movieDAO.getMoviesByCategory('Category');

      expect(
        result,
        isInstanceOf<List<Movie>>(),
      );
      expect(
        result.length,
        equals(1),
      );
    });
    test('Get by id test', () async {
      final result = await movieDAO.getMovieById(1);

      expect(
        result,
        isInstanceOf<Movie>(),
      );
    });
    test('Get by relation test', () async {
      final result = await movieDAO.getRelatedMovies(
        1,
        'Related',
      );

      expect(
        result,
        isInstanceOf<List<Movie>>(),
      );
      expect(
        result.length,
        equals(1),
      );
    });
    test('Get by genre test', () async {
      final result = await movieDAO.getMoviesByGenre('%${1}%');

      expect(
        result,
        isInstanceOf<List<Movie>>(),
      );
      expect(
        result.length,
        equals(1),
      );
    });
    test('Get by title test', () async {
      final result = await movieDAO.getMoviesByTitle('title');

      expect(
        result,
        isInstanceOf<List<Movie>>(),
      );
      expect(
        result.length,
        equals(2),
      );
    });
    test('Get all test', () async {
      final result = await movieDAO.getAllMovies();

      expect(
        result,
        isInstanceOf<List<Movie>>(),
      );
      expect(
        result.length,
        equals(2),
      );
    });
  });
}
