import 'package:movieguide/data/model/mapper/data_mapper.dart';
import 'package:movieguide/data/model/movie_detail_data.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';

class MovieDetailMapper extends DataMapper<MovieDetailData, MovieDetail> {
  @override
  MovieDetailData mapToData(MovieDetail entity) {
    return MovieDetailData(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      belongsToCollection: entity.belongsToCollection,
      budget: entity.budget,
      homepage: entity.homepage,
      id: entity.id,
      imdbId: entity.imdbId,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      revenue: entity.revenue,
      runtime: entity.runtime,
      status: entity.status,
      tagline: entity.tagline,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }

  @override
  MovieDetail mapToDomain(MovieDetailData data) {
    return MovieDetail(
      adult: data.adult,
      backdropPath: data.backdropPath,
      belongsToCollection: data.belongsToCollection,
      budget: data.budget,
      homepage: data.homepage,
      id: data.id,
      imdbId: data.imdbId,
      originalLanguage: data.originalLanguage,
      originalTitle: data.originalTitle,
      overview: data.overview,
      popularity: data.popularity,
      posterPath: data.posterPath,
      releaseDate: data.releaseDate,
      revenue: data.revenue,
      runtime: data.runtime,
      status: data.status,
      tagline: data.tagline,
      title: data.title,
      video: data.video,
      voteAverage: data.voteAverage,
      voteCount: data.voteCount,
    );
  }
}
