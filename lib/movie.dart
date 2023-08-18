class Movie {
  final int id;
  final String title;
  final String originalTitle;
  final List<String> genres;
  final String releaseDate;
  final String voteAverage;
  final String overview;
  final String backdrop;
  final String poster;

  Movie(
    this.id,
    this.title,
    this.originalTitle,
    this.genres,
    this.poster,
    this.backdrop,
    this.releaseDate,
    this.voteAverage,
    this.overview,
  );
}
