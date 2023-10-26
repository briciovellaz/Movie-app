import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../core/util/data_state.dart';
import '../../../core/util/enums.dart';
import '../../../data/repository/database_movie_repository.dart';
import '../../../data/repository/genres_repository.dart';
import '../../entity/genre.dart';
import '../genres_usecase_interface.dart';

class FetchGenresUsecase implements GenresUseCase<void, void> {
  final GenresRepository remoteRepository;
  final MovieDatabaseRepository databaseRepository;

  FetchGenresUsecase({
    required this.remoteRepository,
    required this.databaseRepository,
  });

  @override
  Future<void> call({void params}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none){
      await remoteRepository.fetchData();
      DataState<List<Genre>> data = await remoteRepository.getAll();
      if (data.state == ElementState.success) {
        if (remoteRepository.hasGenres()) {
          for (var genre in data.data!) {
            databaseRepository.saveGenre(genre);
          }
        }
      }
    }
  }
}
