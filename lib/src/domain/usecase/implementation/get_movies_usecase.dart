import '../../../core/parameter/fetch_movies_parameters.dart';
import '../../../core/util/data_state.dart';
import '../../../data/repository/movie_repository.dart';
import '../../entity/movie.dart';

import '../usecase_interface.dart';

class GetMoviesUseCase
    implements UseCase<DataState<List<Movie>>, FetchMovieParameters> {
  final MovieRepository repository;

  GetMoviesUseCase({required this.repository});

  @override
  Future<DataState<List<Movie>>> call({
    FetchMovieParameters? params,
  }) async =>
      await repository.getMovies(
        params: params!.params,
        endpoint: params.endpoint,
        id: params.id,
      );
}
