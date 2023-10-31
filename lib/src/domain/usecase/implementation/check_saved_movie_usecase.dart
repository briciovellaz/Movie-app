import '../../../data/repository/database_movie_repository.dart';
import '../../entity/database/movie_category.dart';
import '../usecase_interface.dart';

class CheckSavedMovieUsecase implements UseCase<bool, MovieCategory> {
  final MovieDatabaseRepository databaseRepository;

  CheckSavedMovieUsecase({required this.databaseRepository});

  @override
  Future<bool> call({MovieCategory? params}) {
    return databaseRepository.existsCategory(params!);
  }

}
