import '../../data/datasource/local/movie_database.dart';
import '../../data/repository/database_movie_repository.dart';
import '../../data/repository/genres_repository.dart';
import '../../data/repository/movie_repository.dart';
import '../../domain/usecase/implementation/check_saved_movie_usecase.dart';
import '../../domain/usecase/implementation/fetch_genres_usecase.dart';
import '../../domain/usecase/implementation/get_genres_by_id_usecase.dart';
import '../../domain/usecase/implementation/get_movies_usecase.dart';
import '../../domain/usecase/implementation/save_movies_usecase.dart';
import '../../presentation/bloc/genres_bloc.dart';
import '../../presentation/bloc/genres_by_id_bloc.dart';

import '../../presentation/bloc/movies_bloc.dart';
import '../../presentation/bloc/saved_movies_bloc.dart';
import 'strings.dart' as strings;

class Dependencies {
  late MoviesBloc _moviesBloc;
  late GenresBloc _genresBloc;
  late GenresByIdBloc _genresByIdBloc;
  late MovieDatabase _database;
  late MovieRepository _remoteRepository;
  late MovieDatabaseRepository _databaseRepository;
  late GenresRepository _genresRepository;
  late SavedMoviesBloc _savedMoviesBloc;

  Future<void> load() async {
    _database =
        await $FloorMovieDatabase.databaseBuilder(strings.databaseName).build();
    _remoteRepository = MovieRepository();
    _databaseRepository = MovieDatabaseRepository(_database);
    _genresRepository = GenresRepository();
    _genresByIdBloc = GenresByIdBloc(
      usecase: GetGenresByIdUsecase(databaseRepository: _databaseRepository),
    );
    _moviesBloc = MoviesBloc(
      usecase: GetMoviesUseCase(
        remoteRepository: _remoteRepository,
        databaseRepository: _databaseRepository,
      ),
    );
    _genresBloc = GenresBloc(
      usecase: FetchGenresUsecase(
        remoteRepository: _genresRepository,
        databaseRepository: _databaseRepository,
      ),
    );
    _savedMoviesBloc = SavedMoviesBloc(
      updateSavedUsecase:
          SaveMoviesUsecase(databaseRepository: _databaseRepository),
      checkSavedMovieUsecase: CheckSavedMovieUsecase(
        databaseRepository: _databaseRepository,
      ),
    );
  }

  Future<void> initialize() async {
    _genresByIdBloc.initialize();
    _genresBloc.initialize();
    _moviesBloc.initialize();
  }

  Future<void> dispose() async {
    _moviesBloc.dispose();
    _genresBloc.dispose();
    _genresByIdBloc.dispose();
  }

  MoviesBloc get moviesBloc => _moviesBloc;

  GenresBloc get genresBloc => _genresBloc;

  GenresByIdBloc get genresByIdBloc => _genresByIdBloc;

  SavedMoviesBloc get savedMoviesBloc => _savedMoviesBloc;

  MovieDatabase get database => _database;
}
