import '../../core/bloc/bloc_interface.dart';
import '../../data/repository/genres_repository.dart';
import '../../domain/usecase/genres_usecase_interface.dart';
import '../../domain/usecase/implementation/fetch_genres_usecase.dart';

class GenresBloc implements IBloc {
  final GenresUseCase usecase = FetchGenresUsecase(repository: GenresRepository());

  @override
  void dispose() {}

  void preloadGenres() => usecase.call();

  @override
  void initialize() {
    preloadGenres();
  }
}
