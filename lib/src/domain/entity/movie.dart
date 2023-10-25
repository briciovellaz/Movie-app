import 'package:floor/floor.dart';

@Entity(tableName: 'movies')
class Movie {
  final bool adult;
  final double popularity;
  @PrimaryKey()
  final int id;
  int voteCount = 0;
  final String title;
  @ColumnInfo(name: 'original_title')
  final String originalTitle;
  final bool video;
  final List<int> genres;
  @ColumnInfo(name: 'original_language')
  final String originalLanguage;
  @ColumnInfo(name: 'release_date')
  final String releaseDate;
  @ColumnInfo(name: 'vote_average')
  final double voteAverage;
  final String overview;
  final String backdrop;
  final String poster;

  void incrementVoteCount() {
    voteCount++;
  }

  Movie({
    required this.adult,
    required this.backdrop,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.poster,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  @override
  bool operator ==(Object other) =>
      other is Movie &&
          other.runtimeType == runtimeType &&
          other.id == id;

  @override
  int get hashCode => id.hashCode;
}
