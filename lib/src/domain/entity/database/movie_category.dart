import 'package:floor/floor.dart';

import '../movie.dart';

@Entity(
  tableName: 'movie_category',
  primaryKeys: [
    'movie_id',
    'category',
  ],
  foreignKeys: [
    ForeignKey(
      childColumns: ['movie_id'],
      parentColumns: ['id'],
      entity: Movie,
      onDelete: ForeignKeyAction.cascade,
      onUpdate: ForeignKeyAction.cascade,
    ),
  ],
)
class MovieCategory {
  @ColumnInfo(name: 'movie_id')
  final int movieId;

  @Index(value: ['category'])
  final String category;

  MovieCategory({
    required this.movieId,
    required this.category,
  });
}
