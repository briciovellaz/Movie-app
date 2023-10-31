// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMovieDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieDatabaseBuilder databaseBuilder(String name) =>
      _$MovieDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MovieDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MovieDatabaseBuilder(null);
}

class _$MovieDatabaseBuilder {
  _$MovieDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MovieDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MovieDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MovieDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MovieDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MovieDatabase extends MovieDatabase {
  _$MovieDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDAO? _movieDAOInstance;

  GenreDAO? _genreDAOInstance;

  MovieCategoryDAO? _movieCategoryDAOInstance;

  RelatedMovieDAO? _relatedMovieDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movies` (`adult` INTEGER NOT NULL, `popularity` REAL NOT NULL, `id` INTEGER NOT NULL, `voteCount` INTEGER NOT NULL, `title` TEXT NOT NULL, `original_title` TEXT NOT NULL, `video` INTEGER NOT NULL, `genres` TEXT NOT NULL, `original_language` TEXT NOT NULL, `release_date` TEXT NOT NULL, `vote_average` REAL NOT NULL, `overview` TEXT NOT NULL, `backdrop` TEXT NOT NULL, `poster` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movie_category` (`movie_id` INTEGER NOT NULL, `category` TEXT NOT NULL, FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`) ON UPDATE CASCADE ON DELETE CASCADE, PRIMARY KEY (`movie_id`, `category`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `genres` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `related_movies` (`movie_id` INTEGER NOT NULL, `relation` TEXT NOT NULL, `related_movie_id` INTEGER NOT NULL, PRIMARY KEY (`movie_id`, `relation`, `related_movie_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDAO get movieDAO {
    return _movieDAOInstance ??= _$MovieDAO(database, changeListener);
  }

  @override
  GenreDAO get genreDAO {
    return _genreDAOInstance ??= _$GenreDAO(database, changeListener);
  }

  @override
  MovieCategoryDAO get movieCategoryDAO {
    return _movieCategoryDAOInstance ??=
        _$MovieCategoryDAO(database, changeListener);
  }

  @override
  RelatedMovieDAO get relatedMovieDAO {
    return _relatedMovieDAOInstance ??=
        _$RelatedMovieDAO(database, changeListener);
  }
}

class _$MovieDAO extends MovieDAO {
  _$MovieDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'movies',
            (Movie item) => <String, Object?>{
                  'adult': item.adult ? 1 : 0,
                  'popularity': item.popularity,
                  'id': item.id,
                  'voteCount': item.voteCount,
                  'title': item.title,
                  'original_title': item.originalTitle,
                  'video': item.video ? 1 : 0,
                  'genres': _genreConverter.encode(item.genres),
                  'original_language': item.originalLanguage,
                  'release_date': item.releaseDate,
                  'vote_average': item.voteAverage,
                  'overview': item.overview,
                  'backdrop': item.backdrop,
                  'poster': item.poster
                }),
        _movieDeletionAdapter = DeletionAdapter(
            database,
            'movies',
            ['id'],
            (Movie item) => <String, Object?>{
                  'adult': item.adult ? 1 : 0,
                  'popularity': item.popularity,
                  'id': item.id,
                  'voteCount': item.voteCount,
                  'title': item.title,
                  'original_title': item.originalTitle,
                  'video': item.video ? 1 : 0,
                  'genres': _genreConverter.encode(item.genres),
                  'original_language': item.originalLanguage,
                  'release_date': item.releaseDate,
                  'vote_average': item.voteAverage,
                  'overview': item.overview,
                  'backdrop': item.backdrop,
                  'poster': item.poster
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final DeletionAdapter<Movie> _movieDeletionAdapter;

  @override
  Future<List<Movie>> getMoviesByCategory(String category) async {
    return _queryAdapter.queryList(
        'SELECT * FROM movies WHERE id IN (SELECT movie_id FROM movie_category WHERE category = ?1)',
        mapper: (Map<String, Object?> row) => Movie(adult: (row['adult'] as int) != 0, backdrop: row['backdrop'] as String, genres: _genreConverter.decode(row['genres'] as String), id: row['id'] as int, originalLanguage: row['original_language'] as String, originalTitle: row['original_title'] as String, overview: row['overview'] as String, popularity: row['popularity'] as double, poster: row['poster'] as String, releaseDate: row['release_date'] as String, title: row['title'] as String, video: (row['video'] as int) != 0, voteAverage: row['vote_average'] as double, voteCount: row['voteCount'] as int),
        arguments: [category]);
  }

  @override
  Future<Movie?> getMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM movies WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Movie(
            adult: (row['adult'] as int) != 0,
            backdrop: row['backdrop'] as String,
            genres: _genreConverter.decode(row['genres'] as String),
            id: row['id'] as int,
            originalLanguage: row['original_language'] as String,
            originalTitle: row['original_title'] as String,
            overview: row['overview'] as String,
            popularity: row['popularity'] as double,
            poster: row['poster'] as String,
            releaseDate: row['release_date'] as String,
            title: row['title'] as String,
            video: (row['video'] as int) != 0,
            voteAverage: row['vote_average'] as double,
            voteCount: row['voteCount'] as int),
        arguments: [id]);
  }

  @override
  Future<List<Movie>> getRelatedMovies(
    int id,
    String relation,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM movies WHERE id IN (SELECT related_movie_id FROM related_movies WHERE movie_id = ?1 AND relation = ?2)',
        mapper: (Map<String, Object?> row) => Movie(adult: (row['adult'] as int) != 0, backdrop: row['backdrop'] as String, genres: _genreConverter.decode(row['genres'] as String), id: row['id'] as int, originalLanguage: row['original_language'] as String, originalTitle: row['original_title'] as String, overview: row['overview'] as String, popularity: row['popularity'] as double, poster: row['poster'] as String, releaseDate: row['release_date'] as String, title: row['title'] as String, video: (row['video'] as int) != 0, voteAverage: row['vote_average'] as double, voteCount: row['voteCount'] as int),
        arguments: [id, relation]);
  }

  @override
  Future<List<Movie>> getMoviesByGenre(String genre) async {
    return _queryAdapter.queryList('SELECT * FROM movies WHERE genres LIKE ?1',
        mapper: (Map<String, Object?> row) => Movie(
            adult: (row['adult'] as int) != 0,
            backdrop: row['backdrop'] as String,
            genres: _genreConverter.decode(row['genres'] as String),
            id: row['id'] as int,
            originalLanguage: row['original_language'] as String,
            originalTitle: row['original_title'] as String,
            overview: row['overview'] as String,
            popularity: row['popularity'] as double,
            poster: row['poster'] as String,
            releaseDate: row['release_date'] as String,
            title: row['title'] as String,
            video: (row['video'] as int) != 0,
            voteAverage: row['vote_average'] as double,
            voteCount: row['voteCount'] as int),
        arguments: [genre]);
  }

  @override
  Future<List<Movie>> getMoviesByTitle(String title) async {
    return _queryAdapter.queryList('SELECT * FROM movies WHERE title LIKE ?1',
        mapper: (Map<String, Object?> row) => Movie(
            adult: (row['adult'] as int) != 0,
            backdrop: row['backdrop'] as String,
            genres: _genreConverter.decode(row['genres'] as String),
            id: row['id'] as int,
            originalLanguage: row['original_language'] as String,
            originalTitle: row['original_title'] as String,
            overview: row['overview'] as String,
            popularity: row['popularity'] as double,
            poster: row['poster'] as String,
            releaseDate: row['release_date'] as String,
            title: row['title'] as String,
            video: (row['video'] as int) != 0,
            voteAverage: row['vote_average'] as double,
            voteCount: row['voteCount'] as int),
        arguments: [title]);
  }

  @override
  Future<List<Movie>> getAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movies',
        mapper: (Map<String, Object?> row) => Movie(
            adult: (row['adult'] as int) != 0,
            backdrop: row['backdrop'] as String,
            genres: _genreConverter.decode(row['genres'] as String),
            id: row['id'] as int,
            originalLanguage: row['original_language'] as String,
            originalTitle: row['original_title'] as String,
            overview: row['overview'] as String,
            popularity: row['popularity'] as double,
            poster: row['poster'] as String,
            releaseDate: row['release_date'] as String,
            title: row['title'] as String,
            video: (row['video'] as int) != 0,
            voteAverage: row['vote_average'] as double,
            voteCount: row['voteCount'] as int));
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    await _movieDeletionAdapter.delete(movie);
  }
}

class _$GenreDAO extends GenreDAO {
  _$GenreDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _genreInsertionAdapter = InsertionAdapter(
            database,
            'genres',
            (Genre item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _genreDeletionAdapter = DeletionAdapter(
            database,
            'genres',
            ['id'],
            (Genre item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Genre> _genreInsertionAdapter;

  final DeletionAdapter<Genre> _genreDeletionAdapter;

  @override
  Future<Genre?> getGenreById(int id) async {
    return _queryAdapter.query('SELECT * FROM genres WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Genre(id: row['id'] as int, name: row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertGenre(Genre genre) async {
    await _genreInsertionAdapter.insert(genre, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteGenre(Genre genre) async {
    await _genreDeletionAdapter.delete(genre);
  }
}

class _$MovieCategoryDAO extends MovieCategoryDAO {
  _$MovieCategoryDAO(
    this.database,
    this.changeListener,
  )   : _movieCategoryInsertionAdapter = InsertionAdapter(
            database,
            'movie_category',
            (MovieCategory item) => <String, Object?>{
                  'movie_id': item.movieId,
                  'category': item.category
                }),
        _movieCategoryDeletionAdapter = DeletionAdapter(
            database,
            'movie_category',
            ['movie_id', 'category'],
            (MovieCategory item) => <String, Object?>{
                  'movie_id': item.movieId,
                  'category': item.category
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<MovieCategory> _movieCategoryInsertionAdapter;

  final DeletionAdapter<MovieCategory> _movieCategoryDeletionAdapter;

  @override
  Future<void> insertMovieCategory(MovieCategory category) async {
    await _movieCategoryInsertionAdapter.insert(
        category, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteMovieCategory(MovieCategory category) async {
    await _movieCategoryDeletionAdapter.delete(category);
  }
}

class _$RelatedMovieDAO extends RelatedMovieDAO {
  _$RelatedMovieDAO(
    this.database,
    this.changeListener,
  )   : _relatedMovieInsertionAdapter = InsertionAdapter(
            database,
            'related_movies',
            (RelatedMovie item) => <String, Object?>{
                  'movie_id': item.movieId,
                  'relation': item.relation,
                  'related_movie_id': item.relatedMovieId
                }),
        _relatedMovieDeletionAdapter = DeletionAdapter(
            database,
            'related_movies',
            ['movie_id', 'relation', 'related_movie_id'],
            (RelatedMovie item) => <String, Object?>{
                  'movie_id': item.movieId,
                  'relation': item.relation,
                  'related_movie_id': item.relatedMovieId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final InsertionAdapter<RelatedMovie> _relatedMovieInsertionAdapter;

  final DeletionAdapter<RelatedMovie> _relatedMovieDeletionAdapter;

  @override
  Future<void> insertRelation(RelatedMovie relation) async {
    await _relatedMovieInsertionAdapter.insert(
        relation, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteRelation(RelatedMovie relation) async {
    await _relatedMovieDeletionAdapter.delete(relation);
  }
}

// ignore_for_file: unused_element
final _genreConverter = GenreConverter();
