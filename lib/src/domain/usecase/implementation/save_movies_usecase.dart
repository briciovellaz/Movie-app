import '../../../data/repository/database_movie_repository.dart';
import '../../entity/database/movie_category.dart';
import '../usecase_interface.dart';

class SaveMoviesUsecase implements UseCase<void, MovieCategory> {
  final MovieDatabaseRepository databaseRepository;

  SaveMoviesUsecase({required this.databaseRepository});

  @override
  Future<void> call({MovieCategory? params}) async {
    (await databaseRepository.existsCategory(params!))
        ? databaseRepository.removeMovieCategory(params)
        : databaseRepository.saveMovieCategory(params);
  }
}
