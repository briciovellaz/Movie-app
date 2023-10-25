import 'package:flutter/material.dart';

import '../../../core/util/constants.dart' as constants;
import '../../../domain/entity/movie_category.dart';
import '../show_all_button.dart';
import 'main_list_element.dart';

class MainElementsList extends StatefulWidget {
  final MovieCategory listInfo;
  static const double containerHeight = 500;

  const MainElementsList({
    super.key,
    required this.listInfo,
  });

  @override
  State<MainElementsList> createState() => _MainElementsListState();
}

class _MainElementsListState extends State<MainElementsList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Text(
          widget.listInfo.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(
          height: MainElementsList.containerHeight,
          child: PageView.builder(
            itemCount:
                constants.homeMaxElementsPerList > widget.listInfo.movies.length
                    ? widget.listInfo.movies.length
                    : constants.homeMaxElementsPerList + 1,
            scrollDirection: Axis.horizontal,
            itemBuilder: (
              BuildContext context,
              int index,
            ) =>
                index == constants.homeMaxElementsPerList
                    ? ShowAllButton(category: widget.listInfo)
                    : MainListElement(movie: widget.listInfo.movies[index]),
          ),
        ),
      ],
    );
  }
}
