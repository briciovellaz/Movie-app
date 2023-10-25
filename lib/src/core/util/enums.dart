enum ElementState {
  loading,
  success,
  failure,
  empty,
}

enum HomeCategory {
  main,
  secondary,
  extra,
}

enum Endpoint {
  popular(
    'Popular',
    '/popular',
  ),
  topRated(
    'Top rated',
    '/top_rated',
  ),
  upcoming(
    'Upcoming',
    '/upcoming',
  ),
  nowPlaying(
    'Now playing',
    '/now_playing',
  ),
  similar(
    'Similar',
    '/similar',
  ),
  recommended(
    'Recommended',
    '/recommendations',
  ),
  discover(
    'Discover',
    '/discover',
  ),
  search(
    'Search',
    '/search',
  );

  const Endpoint(
    this.title,
    this.endpoint,
  );

  final String title;
  final String endpoint;
}
