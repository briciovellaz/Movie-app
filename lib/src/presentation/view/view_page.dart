import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/parameter/movie_parameters.dart';
import '../../core/util/enums.dart';
import '../bloc/movies_bloc.dart';
import '../widget/home_page/home_stream_builder.dart';

class ViewPage extends StatefulWidget {
  ViewPage({super.key});

  final MovieParameters defaultParameters = MovieParameters();
  final Endpoint mainEndpoint = Endpoint.nowPlaying;
  final Endpoint secondaryEndpoint = Endpoint.upcoming;
  final List<Endpoint> extraEndpoints = [
    Endpoint.topRated,
    Endpoint.popular,
  ];

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final MoviesBloc bloc = Get.find();

  @override
  void initState() {
    super.initState();
    bloc.fetchMovies(
      params: widget.defaultParameters,
      endpoint: widget.mainEndpoint,
    );
    bloc.fetchMovies(
      params: widget.defaultParameters,
      endpoint: widget.secondaryEndpoint,
    );

    for (Endpoint endpoint in widget.extraEndpoints) {
      bloc.fetchMovies(
        params: widget.defaultParameters,
        endpoint: endpoint,
      );
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListView(
      children: [
        HomeStreamBuilder(
          stream: bloc.getStreamFromCategory(category: HomeCategory.main),
          category: HomeCategory.main,
          endpoint: widget.mainEndpoint,
        ),
        HomeStreamBuilder(
          stream: bloc.getStreamFromCategory(category: HomeCategory.secondary),
          category: HomeCategory.secondary,
          endpoint: widget.secondaryEndpoint,
        ),
        for (Endpoint endpoint in widget.extraEndpoints)
          HomeStreamBuilder(
            stream: bloc.getStreamFromEndpoint(endpoint: endpoint),
            category: HomeCategory.extra,
            endpoint: endpoint,
          ),
      ],
    );
  }
}
