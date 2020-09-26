import 'package:equatable/equatable.dart';

import 'base_entity.dart';

class Movie extends Equatable implements Entity {
  final int id;
  final String posterPath;
  final String title;
  final int voteCount;
  final double voteAverage;
  final String releaseDate;
  Movie({
    this.id,
    this.posterPath,
    this.title,
    this.voteCount,
    this.voteAverage,
    this.releaseDate,
  });

  @override
  List<Object> get props =>
      [id, posterPath, title, voteCount, voteAverage, releaseDate];
}
