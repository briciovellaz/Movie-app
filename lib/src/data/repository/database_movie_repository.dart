import '../../domain/entity/database/movie_category.dart';
import '../../domain/entity/database/related_movie.dart';
import '../../domain/entity/genre.dart';
import '../../domain/entity/movie.dart';
import '../../domain/repository/i_database_movie_repository.dart';
import '../datasource/local/movie_database.dart';

class MovieDatabaseRepository implements IDatabaseMovieRepository {
  final MovieDatabase _movieDB;

  const MovieDatabaseRepository(this._movieDB);

  @override
  Future<List<Movie>> getMovies() => _movieDB.movieDAO.getAllMovies();

  @override
  Future<Movie?> getMovieById(int id) =>
      _movieDB.movieDAO.getMovieById(id);

  @override
  Future<List<Movie>> getMoviesByCategory(String category) =>
      _movieDB.movieDAO.getMoviesByCategory(category);

  @override
  Future<List<Movie>> getMovieByGenre(int id) =>
      _movieDB.movieDAO.getMoviesByGenre('%$id%');

  @override
  Future<void> removeMovie({required Movie movie}) =>
      _movieDB.movieDAO.deleteMovie(movie);

  @override
  Future<void> saveMovie({required Movie movie}) =>
      _movieDB.movieDAO.insertMovie(movie);

  @override
  Future<void> saveGenre(Genre genre) => _movieDB.genreDAO.insertGenre(genre);

  @override
  Future<Genre?> getGenreById(int id) => _movieDB.genreDAO.getGenreById(id);

  @override
  Future<void> removeGenre(Genre genre) => _movieDB.genreDAO.deleteGenre(genre);

  @override
  Future<void> saveRelation(RelatedMovie relation) =>
      _movieDB.relatedMovieDAO.insertRelation(relation);

  @override
  Future<void> removeRelation(RelatedMovie relation) =>
      _movieDB.relatedMovieDAO.deleteRelation(relation);

  @override
  Future<void> saveMovieCategory(MovieCategory category) =>
      _movieDB.movieCategoryDAO.insertMovieCategory(category);

  @override
  Future<void> removeMovieCategory(MovieCategory category) =>
      _movieDB.movieCategoryDAO.deleteMovieCategory(category);

  @override
  Future<List<Movie>> getMoviesByTitle(String title) =>
      _movieDB.movieDAO.getMoviesByTitle('%$title%');

  @override
  Future<List<Movie>> getRelatedMovies(int id, String relation) =>
      _movieDB.movieDAO.getRelatedMovies(id, relation);

  @override
  Future<bool> existsCategory(MovieCategory category) async {
    var result = await _movieDB.movieCategoryDAO.existsCategory(
          category.movieId,
          category.category,
        ) ==
        1;
    return result;
  }
}
