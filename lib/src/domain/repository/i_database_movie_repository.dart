import '../entity/database/movie_category.dart';
import '../entity/database/related_movie.dart';
import '../entity/genre.dart';
import '../entity/movie.dart';

abstract class IDatabaseMovieRepository {
  Future<List<Movie>> getMovies();

  Future<List<Movie>> getMoviesByCategory(String category);

  Future<Movie?> getMovieById(int id);

  Future<List<Movie>> getMovieByGenre(int id);

  Future<void> saveMovie({required Movie movie});

  Future<void> removeMovie({required Movie movie});

  Future<void> saveGenre(Genre genre);

  Future<Genre?> getGenreById(int id);

  Future<void> removeGenre(Genre genre);

  Future<void> saveRelation(RelatedMovie relation);

  Future<void> removeRelation(RelatedMovie relation);

  Future<void> saveMovieCategory(MovieCategory category);

  Future<void> removeMovieCategory(MovieCategory category);
}
