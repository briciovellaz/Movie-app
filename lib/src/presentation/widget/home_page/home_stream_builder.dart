import 'package:flutter/material.dart';

import '../../../core/util/enums.dart';
import '../../../core/util/strings.dart' as strings;
import '../../../domain/entity/event/implementation/movie_event.dart';
import '../../../domain/entity/movie.dart';
import '../../../domain/entity/movie_category.dart';
import '../horizontal_movies_list.dart';
import 'main_elements_list.dart';
import 'secondary_movies_list.dart';

class HomeStreamBuilder extends StatefulWidget {
  const HomeStreamBuilder({
    super.key,
    required this.stream,
    required this.category,
    required this.endpoint,
  });

  final Stream<MovieEvent> stream;
  final HomeCategory category;
  final Endpoint endpoint;

  @override
  State<HomeStreamBuilder> createState() => _HomeStreamBuilderState();
}

class _HomeStreamBuilderState extends State<HomeStreamBuilder>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MovieEvent>(
      initialData: MovieEvent.loading(),
      stream: widget.stream,
      builder: (
        BuildContext context,
        AsyncSnapshot<MovieEvent> snapshot,
      ) {
        switch (snapshot.data!.state) {
          case ElementState.success:
            var snapshotData = snapshot.data?.data as List<Movie>;
            MovieCategory data = MovieCategory(
              movies: snapshotData,
              name: widget.endpoint.title,
            );
            switch (widget.category) {
              case HomeCategory.main:
                return MainElementsList(listInfo: data);
              case HomeCategory.secondary:
                return SecondaryMoviesList(listInfo: data);
              case HomeCategory.extra:
                return MoviesList(category: data);
            }
          case ElementState.empty:
            return const Text(strings.noDataErrorText);
          case ElementState.failure:
            return Text(snapshot.data!.error!);
          case ElementState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
