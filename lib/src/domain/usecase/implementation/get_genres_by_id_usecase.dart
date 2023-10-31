import '../../../core/util/data_state.dart';
import '../../entity/genre.dart';
import '../../repository/i_database_movie_repository.dart';
import '../genres_usecase_interface.dart';

class GetGenresByIdUsecase
    implements GenresUseCase<DataState<List<Genre>>, List<int>> {
  final IDatabaseMovieRepository databaseRepository;

  GetGenresByIdUsecase({required this.databaseRepository});

  @override
  Future<DataState<List<Genre>>> call({List<int>? params}) async {
    final List<Genre> data = [];

    for (int id in params!) {
      Genre? genre = await databaseRepository.getGenreById(id);
      if (genre != null) data.add(genre);
    }

    return DataSuccess(data);
  }
}
