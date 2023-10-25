import '../../util/strings.dart' as strings;

mixin RegionParameter {
  String? region;

  String get regionParam =>
      (region == null) ? strings.emptyString : '${strings.apiRegion}$region';
}
