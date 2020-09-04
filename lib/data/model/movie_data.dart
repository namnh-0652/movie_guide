import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movieguide/data/model/mapable_data.dart';
import 'package:movieguide/domain/entities/movie.dart';
part 'movie_data.g.dart';

@JsonSerializable()
class MovieData extends Equatable implements MapAbleData<Movie> {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'release_date')
  final String releaseDate;

  MovieData({
    this.id,
    this.posterPath,
    this.title,
    this.voteCount,
    this.voteAverage,
    this.releaseDate,
  });

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  @override
  List<Object> get props =>
      [id, posterPath, title, voteCount, voteAverage, releaseDate];

  @override
  Movie map() {
    return Movie(
      id: id,
      posterPath: posterPath,
      title: title,
      voteCount: voteCount,
      voteAverage: voteAverage,
      releaseDate: releaseDate,
    );
  }
}
