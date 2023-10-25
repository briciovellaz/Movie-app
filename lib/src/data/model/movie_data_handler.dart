import '../../core/util/strings.dart' as strings;

import '../../domain/entity/movie.dart';

class MovieDataHandler {
  final bool adult;
  final double popularity;
  final int id;
  final int voteCount;
  final String title;
  final String originalTitle;
  final bool video;
  final List<int> genres;
  final String originalLanguage;
  final String releaseDate;
  final String voteAverage;
  final String overview;
  final String backdrop;
  final String poster;

  String get backdropFullPath => '${strings.imageUrlPrefix}$backdrop';

  String get posterFullPath => '${strings.imageUrlPrefix}$poster';

  MovieDataHandler({
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

  factory MovieDataHandler.fromJson(Map<String, dynamic> json) {
    return MovieDataHandler(
      adult: json['adult'],
      backdrop: json['backdrop_path'],
      genres: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      poster: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'].toStringAsFixed(1),
      voteCount: json['vote_count'],
    );
  }

  static Movie mockMovie() {
    return Movie(
      adult: false,
      backdrop:
          'https://www.themoviedb.org/t/p/original/9n2tJBplPbgR2ca05hS5CKXwP2c.jpg',
      genres: [
        12,
        16,
        35,
        14,
      ],
      id: 1,
      originalLanguage: 'en',
      originalTitle: 'The Super Mario Bros. Movie',
      overview:
          'While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi '
          'are transported down a mysterious pipe and wander into a magical new world. But when the '
          'brothers are separated, Mario embarks on an epic quest to find Luigi.',
      popularity: 58,
      poster:
          'https://www.themoviedb.org/t/p/original/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg',
      releaseDate: '2023-04-05',
      title: 'The Super Mario Bros. Movie',
      video: false,
      voteAverage: 7.8,
      voteCount: 0,
    );
  }

  Movie toModel() {
    return Movie(
      adult: adult,
      backdrop: backdropFullPath,
      genres: genres,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      poster: posterFullPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: double.parse(voteAverage),
      voteCount: voteCount,
    );
  }
}
