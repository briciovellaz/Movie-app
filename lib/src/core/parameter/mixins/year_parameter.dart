import '../../util/strings.dart' as strings;

mixin YearParameter {
  String? year;

  String get yearParam => (year == null)
      ? strings.emptyString
      : '${strings.apiYear}$year';
}
