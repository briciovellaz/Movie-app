import '../../../core/util/enums.dart';

abstract class Event<T> {
  final ElementState state;
  final T? data;
  final String? error;

  const Event({required this.state, this.data, this.error});

  @override
  bool operator ==(Object other) =>
      other is Event<T> &&
          other.runtimeType == runtimeType &&
          other.state == this.state;

  @override
  int get hashCode => state.hashCode;
}
