import 'package:flutter/material.dart';

import '../../domain/entity/movie.dart';
import 'detailed_tile_data.dart';

class DetailedTileInfo extends StatelessWidget {
  final Movie movie;

  const DetailedTileInfo({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
