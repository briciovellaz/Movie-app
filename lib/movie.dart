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

  factory Movie.marioExample() {
    return Movie(
      1,
      'The Super Mario Bros. Movie',
      'The Super Mario Bros. Movie',
      ['Animation', 'Family', 'Adventure', 'Fantasy', 'Comedy',],
      'mario_poster',
      'mario_backdrop',
      '2023-04-05',
      '7,8',
      'While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi '
          'are transported down a mysterious pipe and wander into a magical new world. But when the '
          'brothers are separated, Mario embarks on an epic quest to find Luigi.',
    );
  }
}
