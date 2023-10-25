import '../../../core/parameter/fetch_movies_parameters.dart';
import '../../../core/util/data_state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/strings.dart';
import '../../../data/repository/movie_repository.dart';
import '../../entity/database/movie_category.dart';
import '../../entity/movie.dart';

import '../../repository/i_database_movie_repository.dart';
import '../usecase_interface.dart';

class GetMoviesUseCase
    implements UseCase<DataState<List<Movie>>, FetchMovieParameters> {
  final MovieRepository remoteRepository;
  final IDatabaseMovieRepository databaseRepository;

  GetMoviesUseCase({
    required this.remoteRepository,
    required this.databaseRepository,
  });

  @override
  Future<DataState<List<Movie>>> call({
    FetchMovieParameters? params,
  }) async {
    final DataState<List<Movie>> data = await remoteRepository.getMovies(
      params: params!.params,
      endpoint: params.endpoint,
      id: params.id,
    );

    if (data.state == ElementState.success) {
      await Future.forEach(
        data.data!,
        (Movie movie) async {
          databaseRepository.saveMovie(movie: movie);
          databaseRepository.saveMovieCategory(
            MovieCategory(
              movieId: movie.id,
              category: params.endpoint.title,
            ),
          );
        },
      );
      return DataSuccess<List<Movie>>(
        await databaseRepository.getMoviesByCategory(params.endpoint.title),
      );
    } else {
      List<Movie> data =
          await databaseRepository.getMoviesByCategory(params.endpoint.title);
      return (data.isEmpty) ? DataFailed(noDataErrorText) : DataSuccess(data);
    }
  }
}
