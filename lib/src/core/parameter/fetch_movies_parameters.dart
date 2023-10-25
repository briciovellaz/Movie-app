import '../util/enums.dart';
import 'movie_parameters.dart';

class FetchMovieParameters {
  final int? id;
  final Endpoint endpoint;
  final MovieParameters params;

  FetchMovieParameters({
    required this.endpoint,
    required this.params,
    this.id,
  });
}
