import 'package:http/http.dart';

import '../../../core/util/strings.dart';

class GenreService {
  Future<Response> getMoviesGenres() => get(
        Uri.parse(
          '$apiBaseUrl/$apiVersion/$genrePath/$moviePath/$listPath?$apiKey',
        ),
      );
}
