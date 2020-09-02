import 'dart:convert';

import 'package:movieguide/data/model/mapable_data.dart';
import 'package:movieguide/domain/entities/movie.dart';

class MovieData extends MapAbleData<Movie> {
  int id;
  String posterPath;
  String title;
  int voteCount;
  double voteAverage;
  String releaseDate;

  MovieData({
    this.id,
    this.posterPath,
    this.title,
    this.voteCount,
    this.voteAverage,
    this.releaseDate,
  });

  MovieData copyWith({
    int id,
    String posterPath,
    String title,
    int voteCount,
    double voteAverage,
    String releaseDate,
  }) {
    return MovieData(
      id: id ?? this.id,
      posterPath: posterPath ?? this.posterPath,
      title: title ?? this.title,
      voteCount: voteCount ?? this.voteCount,
      voteAverage: voteAverage ?? this.voteAverage,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'poster_path': posterPath,
      'title': title,
      'vote_count': voteCount,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }

  factory MovieData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MovieData(
      id: map['id'],
      posterPath: map['poster_dath'],
      title: map['title'],
      voteCount: map['vote_count'],
      voteAverage: map['vote_average'],
      releaseDate: map['release_date'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieData.fromJson(String source) =>
      MovieData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MovieData(id: $id, posterPath: $posterPath, title: $title, voteCount: $voteCount, voteAverage: $voteAverage, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MovieData &&
        o.id == id &&
        o.posterPath == posterPath &&
        o.title == title &&
        o.voteCount == voteCount &&
        o.voteAverage == voteAverage &&
        o.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        posterPath.hashCode ^
        title.hashCode ^
        voteCount.hashCode ^
        voteAverage.hashCode ^
        releaseDate.hashCode;
  }

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
