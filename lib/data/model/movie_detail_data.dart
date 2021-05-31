import 'package:json_annotation/json_annotation.dart';

import 'package:movieguide/data/model/data_model.dart';

part 'movie_detail_data.g.dart';

@JsonSerializable()
class MovieDetailData extends DataModel {
  bool? adult;
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "belongs_to_collection")
  dynamic belongsToCollection;
  int? budget;
  String? homepage;
  int? id;
  @JsonKey(name: "imdb_id")
  String? imdbId;
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "original_title")
  String? originalTitle;
  String? overview;
  double? popularity;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "release_date")
  String? releaseDate;
  int? revenue;
  int? runtime;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  @JsonKey(name: "vote_avarage")
  double? voteAverage;
  @JsonKey(name: "vote_count")
  int? voteCount;

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
}
