import 'package:equatable/equatable.dart';

import 'package:movieguide/domain/entities/base_entity.dart';

class Movie extends Equatable implements Entity {
  final double? popularity;
  final int? voteCount;
  final bool? video;
  final String? posterPath;
  final int? id;
  final bool? adult;
  final String? backdropPath;
  final String? originalLanguage;
  final String? originalTitle;
  final String? title;
  final double? voteAverage;
  final String? overview;
  final String? releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  @override
  List<Object?> get props {
    return [
      popularity,
      voteCount,
      video,
      posterPath,
      id,
      adult,
      backdropPath,
      originalLanguage,
      originalTitle,
      title,
      voteAverage,
      overview,
      releaseDate,
    ];
  }
}
