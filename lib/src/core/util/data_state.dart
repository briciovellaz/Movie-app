import 'enums.dart';

abstract class DataState<T> {
  final ElementState state;
  final T? data;
  final String? error;

  DataState({
    required this.state,
    this.data,
    this.error,
  });

}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data)
      : super(
          state: ElementState.success,
          data: data,
        );
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String error)
      : super(
          state: ElementState.failure,
          error: error,
        );
}
