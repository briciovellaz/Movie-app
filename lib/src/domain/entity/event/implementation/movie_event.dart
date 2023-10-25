import '../../../../core/util/enums.dart';
import '../../movie.dart';
import '../event.dart';

class MovieEvent extends Event<List<Movie>> {
  const MovieEvent({
    required super.state,
    super.data,
    super.error,
  });

  factory MovieEvent.success({required List<Movie> movies}) => MovieEvent(
        state: ElementState.success,
        data: movies,
      );

  factory MovieEvent.failure({required String error}) => MovieEvent(
        state: ElementState.failure,
        error: error,
      );

  factory MovieEvent.loading() => const MovieEvent(state: ElementState.loading);

  factory MovieEvent.empty() => const MovieEvent(state: ElementState.empty);
}
