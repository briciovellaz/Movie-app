import 'package:floor/floor.dart';

import '../../../../domain/entity/database/related_movie.dart';

@dao
abstract class RelatedMovieDAO {
  @delete
  Future<void> deleteRelation(RelatedMovie relation);

  @insert
  Future<void> insertRelation(RelatedMovie relation);
}
