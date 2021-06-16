import 'package:equatable/equatable.dart';

import 'package:movieguide/domain/entities/base_entity.dart';

class Movie extends Equatable implements Entity {
  final int? id;
  final int? voteCount;
  final String? posterPath;
  final String? title;
  final double? voteAverage;
  final String? releaseDate;

  Movie({
    this.id,
    this.voteCount,
    this.posterPath,
    this.title,
    this.voteAverage,
    this.releaseDate,
  });

  @override
  List<Object?> get props => [
        id,
        voteCount,
        posterPath,
        title,
        voteAverage,
        releaseDate,
      ];
}
