import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:movieguide/data/model/data_model.dart';

part 'movie_detail_data.g.dart';

@JsonSerializable()
class MovieDetailData extends Equatable implements DataModel {
  final bool? adult;
  @JsonKey(name: "backdrop_path")
  final String? backdropPath;
  @JsonKey(name: "belongs_to_collection")
  final dynamic belongsToCollection;
  final int? budget;
  final String? homepage;
  final int? id;
  @JsonKey(name: "imdb_id")
  final String? imdbId;
  @JsonKey(name: "original_language")
  final String? originalLanguage;
  @JsonKey(name: "original_title")
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  @JsonKey(name: "vote_avarage")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;

  MovieDetailData({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.homepage,
    this.id,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });
  factory MovieDetailData.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailDataToJson(this);
  @override
  List<Object?> get props => [
        this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.homepage,
        this.id,
        this.imdbId,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount
      ];
}
