import 'package:floor/floor.dart';
import '../../../../domain/entity/movie.dart';

@dao
abstract class MovieDAO {

  @Query('SELECT * FROM movies '
      'INNER JOIN movie_category ON movies.id = movie_category.movie_id '
      'WHERE movie_category.name = :category')
  Future<List<Movie>> getMoviesByCategory(String category);

  @Query('SELECT * FROM movies WHERE id = :id')
  Future<Movie?> getMovieById(int id);

  @Query('SELECT * FROM movies WHERE genres LIKE :genre')
  Future<List<Movie>> getMoviesByGenre(int genre);

  @Query('SELECT * FROM movies')
  Future<List<Movie>> getAllMovies();

  @delete
  Future<void> deleteMovie(Movie movie);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovie(Movie movie);
  
}
