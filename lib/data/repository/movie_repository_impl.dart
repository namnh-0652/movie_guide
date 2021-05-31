import 'package:dartz/dartz.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/movie_data_mapper.dart';
import 'package:movieguide/data/model/mapper/movie_detail_mapper.dart';
import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/data/repository/remote/response/paged_response.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  final MovieDataMaper movieDataMapper;
  final MovieDetailMapper movieDetailMapper;

  MovieRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
    required this.movieDataMapper,
    required this.movieDetailMapper,
  });

  @override
  Future<Either<Failure, Tuple2<List<Movie>, int>>> getMovies(
      String apiKey, int page, MovieKind kind) async {
    bool isNetworkConnected = await networkInfo.isConnected;
    if (!isNetworkConnected) {
      return Left(NetworkFailure());
    }
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
      return Left(ServerFailure());
    }
    return Right(Tuple2(result, response.nextPage));
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

  @override
  Future<Either<Failure, List<Movie>>> loadFavoriteMovies() async {
    try {
      final movies = await localDataSource.loadFavoriteMovies();
      final result = movies.map((e) => movieDataMapper.mapToDomain(e)).toList();
      return Right(result);
    } catch (e) {
      return Left(CacheFailue());
    }
  }

  Future<Either<Failure, MovieDetail>> getMovieDetail(
    String apiKey,
    int movieId,
  ) async {
    final movieDetail = await remoteDataSource.getMovieDetail(apiKey, movieId);

    return Right(movieDetailMapper.mapToDomain(movieDetail));
  }
}
