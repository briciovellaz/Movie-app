import 'package:floor/floor.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDAO {
  @Query('SELECT * FROM movies WHERE id IN '
      '(SELECT movie_id FROM movie_category WHERE category = :category)')
  Future<List<Movie>> getMoviesByCategory(String category);

  @Query('SELECT * FROM movies WHERE id = :id')
  Future<Movie?> getMovieById(int id);

  @Query('SELECT * FROM movies WHERE id IN '
      '(SELECT related_movie_id FROM related_movies WHERE movie_id = :id AND relation = :relation)')
  Future<List<Movie>> getRelatedMovies(int id, String relation);

  @Query('SELECT * FROM movies WHERE genres LIKE :genre')
  Future<List<Movie>> getMoviesByGenre(String genre);

  @Query('SELECT * FROM movies WHERE title LIKE :title')
  Future<List<Movie>> getMoviesByTitle(String title);

  @Query('SELECT * FROM movies')
  Future<List<Movie>> getAllMovies();

  @delete
  Future<void> deleteMovie(Movie movie);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
}
