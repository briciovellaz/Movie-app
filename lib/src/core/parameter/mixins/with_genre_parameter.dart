import '../../util/strings.dart' as strings;

mixin WGenreParameter {
  int? genre;

  String get withGenreParam => (genre == null)
      ? strings.emptyString
      : '${strings.apiGenresPrefix}$genre';
}
