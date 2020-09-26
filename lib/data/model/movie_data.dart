import 'package:json_annotation/json_annotation.dart';
import 'package:movieguide/data/model/data_model.dart';
part 'movie_data.g.dart';

@JsonSerializable()
class MovieData implements DataModel {
  int? id;
  String? title;
  @JsonKey(name: "vote_count")
  int? voteCount;
  @JsonKey(name: "poster_path")
  String? posterPath;
  @JsonKey(name: "vote_average")
  double? voteAverage;
  @JsonKey(name: "release_date")
  String? releaseDate;

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
}
