// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieData _$MovieDataFromJson(Map<String, dynamic> json) {
  return MovieData(
    id: json['id'] as int,
    posterPath: json['poster_path'] as String,
    title: json['title'] as String,
    voteCount: json['vote_count'] as int,
    voteAverage: (json['vote_average'] as num)?.toDouble(),
    releaseDate: json['release_date'] as String,
  );
}

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
      'id': instance.id,
      'poster_path': instance.posterPath,
      'title': instance.title,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'release_date': instance.releaseDate,
    };
