import '../../../core/util/data_state.dart';
import '../../../data/repository/genres_repository.dart';
import '../../entity/genre.dart';
import '../genres_usecase_interface.dart';

class GetGenresByIdUsecase implements GenresUseCase<DataState<List<Genre>>, List<int>> {
  final GenresRepository repository;

  GetGenresByIdUsecase({required this.repository});

  @override
  Future<DataState<List<Genre>>> call({List<int>? params}) async => repository.getFromIds(params!);
}
