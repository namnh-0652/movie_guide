import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/data_mapper.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/domain/entities/movie.dart';
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
  Future<Either<Failure, List<Movie>>> popularMovies() async {
    bool isNetworkConnected = await networkInfo.isConnected;
    if (!isNetworkConnected) {
      return Left(NetworkFailure());
    }
    final data = await remoteDataSource.popularMovies();
    return Right(dataMapper.collectionMap(data));
  }
}
