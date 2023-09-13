import '../../util/strings.dart' as strings;

mixin ReleaseYearParameter {
  String? releaseYear;

  String get releaseYearParam => (releaseYear == null)
      ? strings.emptyString
      : '${strings.apiReleaseYear}$releaseYear';
}
