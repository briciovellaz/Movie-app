import '../../util/strings.dart' as strings;

mixin PageParameter {
  int? page;

  String get pageParam => (page == null)
      ? '${strings.apiPage}${strings.defaultPage}'
      : '${strings.apiPage}$page';
}
