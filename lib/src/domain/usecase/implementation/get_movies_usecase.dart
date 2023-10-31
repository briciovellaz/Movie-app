import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/parameter/fetch_movies_parameters.dart';
import '../../../core/util/data_state.dart';
import '../../../core/util/enums.dart';
import '../../../core/util/strings.dart';
import '../../../data/repository/movie_repository.dart';
import '../../entity/database/movie_category.dart';
import '../../entity/database/related_movie.dart';
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
    if (params!.endpoint == Endpoint.watchlist ||
        params.endpoint == Endpoint.favorites) {
      List<Movie> data =
          await databaseRepository.getMoviesByCategory(params.endpoint.title);
      return (data.isEmpty) ? DataFailed('No movies to show.') : DataSuccess(data);
    }

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult != ConnectivityResult.none) {
      final DataState<List<Movie>> data = await remoteRepository.getMovies(
        params: params.params,
        endpoint: params.endpoint,
        id: params.id,
      );
      await Future.forEach(
        data.data!,
        (Movie movie) async {
          databaseRepository.saveMovie(movie: movie);
          switch (params.endpoint) {
            case Endpoint.similar || Endpoint.recommended:
              databaseRepository.saveRelation(
                RelatedMovie(
                  movieId: params.id!,
                  relatedMovieId: movie.id,
                  relation: params.endpoint.title,
                ),
              );
              break;
            default:
              databaseRepository.saveMovieCategory(
                MovieCategory(
                  movieId: movie.id,
                  category: params.endpoint.title,
                ),
              );
              break;
          }
        },
      );
    }

    final List<Movie> data;

    switch (params.endpoint) {
      case Endpoint.search:
        data = await databaseRepository
            .getMoviesByTitle(params.params.searchQuery!);
        break;
      case Endpoint.discover:
        data = await databaseRepository.getMovieByGenre(params.params.genre!);
        break;
      case Endpoint.recommended || Endpoint.similar:
        data = await databaseRepository.getRelatedMovies(
          params.id!,
          params.endpoint.title,
        );
        break;
      default:
        data =
            await databaseRepository.getMoviesByCategory(params.endpoint.title);
    }
    return (data.isEmpty) ? DataFailed(noDataErrorText) : DataSuccess(data);
  }
}
