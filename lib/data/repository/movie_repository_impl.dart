import 'package:dartz/dartz.dart';
import 'package:movieguide/data/model/mapper/movie_data_mapper.dart';
import 'package:movieguide/data/model/mapper/movie_detail_mapper.dart';
import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/remote/api/error/api_error.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/data/repository/remote/response/paged_response.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final MovieDataMaper movieDataMapper;
  final MovieDetailMapper movieDetailMapper;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.movieDataMapper,
    required this.movieDetailMapper,
  });

  @override
  Future<Either<ErrorEntity, Tuple2<List<Movie>, int?>>> getMovies(
      String apiKey, int page, MovieKind kind) async {
    try {
      PagedResponse<MovieData> response;
      switch (kind) {
        case MovieKind.popular:
          response = await remoteDataSource.popularMovies(apiKey, page);
          break;
        case MovieKind.rated:
          response = await remoteDataSource.ratedMovies(apiKey, page);
          break;
        case MovieKind.newest:
        default:
          response = await remoteDataSource.latestMovies(apiKey, page);
      }
      final result =
          response.results?.map((e) => movieDataMapper.mapToDomain(e)).toList();
      if (result == null) {
        return Left(ServerError());
      }
      return Right(Tuple2(result, response.nextPage));
    } on ErrorEntity catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> addMovieToFavorite(Movie movie) async {
    try {
      final affectedRows = await localDataSource
          .addMovieToFavorite(movieDataMapper.mapToData(movie));
      return Right(affectedRows > 0);
    } on ErrorEntity catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ErrorEntity, bool>> removeMovieFromFavorite(
      String movieId) async {
    try {
      final affectedRows =
          await localDataSource.removeMovieFromFavorite(movieId);
      return Right(affectedRows > 0);
    } on ErrorEntity catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<ErrorEntity, List<Movie>>> loadFavoriteMovies() async {
    try {
      final movies = await localDataSource.loadFavoriteMovies();
      final result = movies.map((e) => movieDataMapper.mapToDomain(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(e as ErrorEntity);
    }
  }

  Future<Either<ErrorEntity, MovieDetail>> getMovieDetail(
    String apiKey,
    int movieId,
  ) async {
    try {
      final movieDetail =
          await remoteDataSource.getMovieDetail(apiKey, movieId);
      return Right(movieDetailMapper.mapToDomain(movieDetail));
    } on ErrorEntity catch (e) {
      return Left(e);
    }
  }
}
