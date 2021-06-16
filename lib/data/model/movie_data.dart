import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movieguide/data/model/data_model.dart';
part 'movie_data.g.dart';

@JsonSerializable()
class MovieData extends Equatable implements DataModel {
  final int? id;
  final String? title;
  @JsonKey(name: "vote_count")
  final int? voteCount;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "release_date")
  final String? releaseDate;

  MovieData({
    this.id,
    this.title,
    this.voteCount,
    this.posterPath,
    this.voteAverage,
    this.releaseDate,
  });

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);

  @override
  List<Object?> get props =>
      [id, title, voteCount, posterPath, voteAverage, releaseDate];
}
