import 'package:floor/floor.dart';

import '../../../../domain/entity/database/movie_category.dart';

@dao
abstract class MovieCategoryDAO{
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertMovieCategory(MovieCategory category);

  @delete
  Future<void> deleteMovieCategory(MovieCategory category);
}
