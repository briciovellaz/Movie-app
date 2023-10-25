import '../util/strings.dart' as strings;
import 'i_api_parameter.dart';
import 'mixins/adult_parameter.dart';
import 'mixins/language_parameter.dart';
import 'mixins/page_parameter.dart';
import 'mixins/region_parameter.dart';
import 'mixins/release_year_parameter.dart';
import 'mixins/with_genre_parameter.dart';
import 'mixins/year_parameter.dart';

class MovieParameters extends IApiParameters
    with
        PageParameter,
        LanguageParameter,
        RegionParameter,
        AdultParameter,
        ReleaseYearParameter,
        YearParameter,
        WGenreParameter {
  String? searchQuery;

  @override
  String get searchParams =>
      '?${strings.apiSearchQuery}$searchQuery&$adultParam&$langParam&$pageParam&$regionParam&$releaseYearParam&$yearParam';

  @override
  String get discoverParams =>
      '?$withGenreParam&$adultParam&$langParam&$pageParam&$regionParam';

  @override
  String get listParams => '?$pageParam&$langParam&$regionParam';

  MovieParameters({
    bool? adult,
    String? language,
    int? page,
    String? region,
    String? releaseYear,
    String? year,
    String? genre,
    this.searchQuery,
  }) {
    this.page = page;
    this.language = language;
    this.region = region;
    this.adult = adult;
    this.region = region;
    this.releaseYear = releaseYear;
    this.year = year;
    this.genre = genre;
  }

  factory MovieParameters.list({
    String? language,
    int? page,
    String? region,
  }) {
    return MovieParameters(
      language: language,
      page: page,
      region: region,
    );
  }

  factory MovieParameters.search({
    required String query,
    bool? adult,
    String? language,
    int? page,
    String? region,
    String? releaseYear,
    String? year,
  }) {
    return MovieParameters(
      searchQuery: query,
      adult: adult,
      language: language,
      page: page,
      region: region,
      releaseYear: releaseYear,
      year: year,
    );
  }

  factory MovieParameters.discover({
    String? genre,
    int? page,
    bool? adult,
    String? language,
    String? region,
  }) {
    return MovieParameters(
      genre: genre,
      page: page,
      adult: adult,
      language: language,
      region: region,
    );
  }
}
