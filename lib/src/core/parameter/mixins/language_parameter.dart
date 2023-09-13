import '../../util/strings.dart' as strings;

mixin LanguageParameter {
  String? language;

  String get langParam => (language == null)
      ? '${strings.apiLanguage}${strings.defaultLanguage}'
      : '${strings.apiLanguage}$language';
}
