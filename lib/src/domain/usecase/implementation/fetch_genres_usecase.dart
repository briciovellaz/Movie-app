import '../../../data/repository/genres_repository.dart';
import '../genres_usecase_interface.dart';

class FetchGenresUsecase implements GenresUseCase<void, void> {
  final GenresRepository repository;

  FetchGenresUsecase({required this.repository});

  @override
  Future<void> call({void params}) async => repository.fetchData();
}
