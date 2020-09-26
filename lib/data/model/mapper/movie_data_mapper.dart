import 'package:movieguide/data/model/mapper/data_mapper.dart';
import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/domain/entities/movie.dart';

class MovieDataMaper extends DataMapper<MovieData, Movie> {
  @override
  Movie mapToDomain(MovieData data) {
    return Movie(
      id: data.id,
      posterPath: data.posterPath,
      title: data.title,
      voteCount: data.voteCount,
      voteAverage: data.voteAverage,
      releaseDate: data.releaseDate,
    );
  }

  @override
  MovieData mapToData(Movie entity) {
    return MovieData(
      id: entity.id,
      posterPath: entity.posterPath,
      title: entity.title,
      voteCount: entity.voteCount,
      voteAverage: entity.voteAverage,
      releaseDate: entity.releaseDate,
    );
  }
}
