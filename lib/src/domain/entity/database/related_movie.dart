import 'package:floor/floor.dart';

@Entity(
  tableName: 'related_movies',
  primaryKeys: [
    'movie_id',
    'relation',
    'related_movie_id',
  ],
)
class RelatedMovie {
  @ColumnInfo(name: 'movie_id')
  final int movieId;
  final String relation;
  @ColumnInfo(name: 'related_movie_id')
  final int relatedMovieId;

  RelatedMovie({
    required this.movieId,
    required this.relatedMovieId,
    required this.relation,
  });
}
