import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/data_mapper.dart';
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
  final DataMapper dataMapper;

  MovieRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
    @required this.dataMapper,
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
    return Right(
        Tuple2(dataMapper.collectionMap(response.value1), response.value2));
  }
}
