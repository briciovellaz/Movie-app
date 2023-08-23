class Movie {
  final bool adult;
  final double popularity;
  final int id;
  int voteCount = 0;
  final String title;
  final String originalTitle;
  final bool video;
  final List<int> genres;
  final String originalLanguage;
  final String releaseDate;
  final num voteAverage;
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
}
