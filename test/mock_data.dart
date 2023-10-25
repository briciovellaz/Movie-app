import 'package:bricio_vellaz/src/domain/entity/genre.dart';
import 'package:bricio_vellaz/src/domain/entity/movie.dart';

const mockGenreJSONResponse = {
  'genres': [
    {'id': 1, 'name': 'Genre'},
  ],
};

const mockMovieJSONResponse = {
  'results': [
    {
      'adult': false,
      'backdrop_path': 'backdrop',
      'genre_ids': [1, 2, 3],
      'id': 1,
      'original_language': 'original_language',
      'original_title': 'original_title',
      'overview': 'overview',
      'popularity': 1.0,
      'poster_path': 'poster_path',
      'release_date': 'release_date',
      'title': 'title',
      'video': false,
      'vote_average': 1,
      'vote_count': 1,
    },
  ],
};

const mockMovieJSONWithNullsResponse = {
  'results': [
    {
      'adult': false,
      'backdrop_path': null,
      'genre_ids': [1, 2, 3],
      'id': 1,
      'original_language': 'original_language',
      'original_title': 'original_title',
      'overview': 'overview',
      'popularity': 1.0,
      'poster_path': null,
      'release_date': null,
      'title': 'title',
      'video': false,
      'vote_average': 1,
      'vote_count': 1,
    },
  ],
};

Genre mockGenre = Genre(id: 1, name: 'Genre');

Movie mockMovie1 = Movie(
  adult: false,
  backdrop: 'backdrop',
  genres: [1],
  id: 1,
  originalLanguage: 'originalLanguage',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 1,
  poster: 'poster',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 1.0,
  voteCount: 0,
);

Movie mockMovie2 = Movie(
  adult: false,
  backdrop: 'backdrop',
  genres: [2],
  id: 2,
  originalLanguage: 'originalLanguage',
  originalTitle: 'originalTitle',
  overview: 'overview',
  popularity: 2,
  poster: 'poster',
  releaseDate: 'releaseDate',
  title: 'title',
  video: false,
  voteAverage: 2.0,
  voteCount: 1,
);
