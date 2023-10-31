import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../../domain/entity/database/movie_category.dart';
import '../../../domain/entity/database/related_movie.dart';
import '../../../domain/entity/genre.dart';
import '../../../domain/entity/movie.dart';
import 'DAOs/genre_dao.dart';
import 'DAOs/movie_category_dao.dart';
import 'DAOs/movie_dao.dart';
import 'DAOs/related_movie_dao.dart';
import 'converters/genre_converter.dart';

part 'movie_database.g.dart';

@TypeConverters([
  GenreConverter,
])
@Database(
  version: 1,
  entities: [
    Movie,
    MovieCategory,
    Genre,
    RelatedMovie,
  ],
)
abstract class MovieDatabase extends FloorDatabase {
  MovieDAO get movieDAO;

  GenreDAO get genreDAO;

  MovieCategoryDAO get movieCategoryDAO;

  RelatedMovieDAO get relatedMovieDAO;
}
