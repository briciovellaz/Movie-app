import '../../../../core/util/enums.dart';
import '../../genre.dart';
import '../event.dart';

class GenreEvent extends Event<List<Genre>> {
  const GenreEvent({
    required super.state,
    super.data,
    super.error,
  });

  factory GenreEvent.success({required List<Genre> genres}) => GenreEvent(
        state: ElementState.success,
        data: genres,
      );

  factory GenreEvent.failure({required String error}) => GenreEvent(
        state: ElementState.failure,
        error: error,
      );

  factory GenreEvent.loading() => const GenreEvent(state: ElementState.loading);

  factory GenreEvent.empty() => const GenreEvent(state: ElementState.empty);
}
