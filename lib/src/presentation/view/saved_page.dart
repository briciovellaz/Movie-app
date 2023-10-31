import 'package:flutter/material.dart';

import '../../core/util/constants.dart';
import '../../core/util/enums.dart';
import '../widget/saved_page/saved_movies_streambuilder.dart';


class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage>{
  final List<Endpoint> _lists = [
    Endpoint.favorites,
    Endpoint.watchlist,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _lists.length,
      child: Scaffold(
        appBar: AppBar(
          leading: TabBar(
            tabs: [
              for (var endpoint in _lists)
                Tab(
                  text: endpoint.title,
                ),
            ],
            labelColor: Theme.of(context).colorScheme.secondary,
          ),
          leadingWidth: MediaQuery.of(context).size.width,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: mainPadding),
          child: TabBarView(
            children: [
              for (var endpoint in _lists) SavedMoviesStreamBuilder(endpoint: endpoint),
            ],
          ),
        ),
      ),
    );
  }

}
