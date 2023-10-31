import '../../core/bloc/bloc_interface.dart';
import '../../domain/entity/database/movie_category.dart';
import '../../domain/usecase/implementation/check_saved_movie_usecase.dart';
import '../../domain/usecase/implementation/save_movies_usecase.dart';

class SavedMoviesBloc implements IBloc {
  SaveMoviesUsecase updateSavedUsecase;
  CheckSavedMovieUsecase checkSavedMovieUsecase;

  SavedMoviesBloc({
    required this.updateSavedUsecase,
    required this.checkSavedMovieUsecase,
  });

  @override
  void initialize() {}

  Future<bool> isSaved(int id, String category) async {
    return await checkSavedMovieUsecase.call(
      params: MovieCategory(
        movieId: id,
        category: category,
      ),
    );
  }

  void updateSaved(int id, String category) async {
    await updateSavedUsecase.call(
      params: MovieCategory(
        movieId: id,
        category: category,
      ),
    );
  }

  @override
  void dispose() {}
}
