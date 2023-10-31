import 'package:floor/floor.dart';

import '../../../../domain/entity/database/movie_category.dart';

@dao
abstract class MovieCategoryDAO {
  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertMovieCategory(MovieCategory category);

  @Query(
      'SELECT COUNT(*) FROM movie_category '
          'WHERE movie_id = :id AND category = :category')
  Future<int?> existsCategory(
    int id,
    String category,
  );

  @delete
  Future<void> deleteMovieCategory(MovieCategory category);
}
