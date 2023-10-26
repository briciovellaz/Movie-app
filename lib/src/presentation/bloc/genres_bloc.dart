import '../../core/bloc/bloc_interface.dart';
import '../../domain/usecase/genres_usecase_interface.dart';

class GenresBloc implements IBloc {
  final GenresUseCase usecase;

  GenresBloc({required this.usecase});

  @override
  void dispose() {}

  void preloadGenres() => usecase.call();

  @override
  void initialize() {
    preloadGenres();
  }
}
