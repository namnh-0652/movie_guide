import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/movie_data_mapper.dart';
import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final MovieDataMaper movieDataMapper;

  MovieRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
    @required this.movieDataMapper,
  });

  @override
  Future<Either<Failure, Tuple2<List<Movie>, int>>> getMovies(
      String apiKey, int page, MovieKind kind) async {
    // TODO: if kind = favorites, just demo with local datasource
    bool isNetworkConnected = await networkInfo.isConnected;
    if (!isNetworkConnected) {
      return Left(NetworkFailure());
    }
    Tuple2<List<MovieData>, int> response;
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
        response.value1.map((e) => movieDataMapper.mapToDomain(e)).toList();
    return Right(Tuple2(result, response.value2));
  }

  @override
  Future<Either<Failure, bool>> addMovieToFavorite(Movie movie) async {
    final affectedRows = await localDataSource
        .addMovieToFavorite(movieDataMapper.mapToData(movie));
    if (affectedRows <= 0) {
      return Left(CacheFailue());
    }
    return Right(true);
  }

  @override
  Future<Either<Failure, bool>> removeMovieFromFavorite(String movieId) async {
    final affectedRows = await localDataSource.removeMovieFromFavorite(movieId);
    if (affectedRows <= 0) {
      return Left(CacheFailue());
    }
    return Right(true);
  }
}
