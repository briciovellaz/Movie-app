import 'dart:async';

import '../../core/bloc/bloc_interface.dart';
import '../../core/util/data_state.dart';
import '../../core/util/enums.dart';
import '../../core/util/strings.dart';
import '../../data/repository/genres_repository.dart';
import '../../domain/entity/event/implementation/genre_event.dart';
import '../../domain/entity/genre.dart';
import '../../domain/usecase/genres_usecase_interface.dart';
import '../../domain/usecase/implementation/get_genres_by_id_usecase.dart';

class GenresByIdBloc implements IBloc {
  late final GenresUseCase usecase;
  final _genres = StreamController<GenreEvent>();

  Stream<GenreEvent> get genres => _genres.stream;

  GenresByIdBloc({GenresUseCase? usecase}) {
    (usecase == null)
        ? this.usecase = GetGenresByIdUsecase(repository: GenresRepository())
        : this.usecase = usecase;
  }

  @override
  void dispose() => _genres.close();

  void fetchGenres(List<int> ids) async {
    _genres.sink.add(GenreEvent.loading());
    DataState<List<Genre>> data = await usecase.call(params: ids);
    if(data.state==ElementState.success){
      (data.data!.isNotEmpty)
          ? _genres.sink.add(GenreEvent.success(genres: data.data!))
          : _genres.sink.add(GenreEvent.empty());
    }
    else {
      _genres.sink.add(GenreEvent.failure(error: noDataErrorText));
    }
  }

  @override
  void initialize() {

  }
}
