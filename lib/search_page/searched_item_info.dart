import 'package:flutter/material.dart';

import '../movie.dart';
import 'searched_item_detail.dart';

class SearchedItemInfo extends StatelessWidget {
  static const int infoFlex = 3;
  final Movie movie;

  const SearchedItemInfo({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: infoFlex,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            movie.title,
            textAlign: TextAlign.start,
          ),
          InfoDetail(
            icon: Icons.calendar_month_outlined,
            info: movie.releaseDate,
          ),
          InfoDetail(
            icon: Icons.star,
            info: '${movie.voteAverage}',
          ),
        ],
      ),
    );
  }
}
