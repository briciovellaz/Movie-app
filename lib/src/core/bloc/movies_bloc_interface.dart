import '../util/enums.dart';
import 'bloc_interface.dart';

abstract class IMoviesBloc<T> implements IBloc {
  void fetchMovies({
    T? params,
    required Endpoint endpoint,
    int? id,
  });
}
