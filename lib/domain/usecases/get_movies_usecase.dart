import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';

class GetMovieUseCase
    extends BaseUseCase<Tuple2<List<Movie>, int>, GetMovieUseCaseParams> {
  final MovieRepository repository;

  GetMovieUseCase({@required this.repository});

  @override
  Future<Either<Failure, Tuple2<List<Movie>, int>>> call(
      GetMovieUseCaseParams params) async {
    return repository.getMovies(params.apiKey, params.page, params.kind);
  }
}

class GetMovieUseCaseParams extends Equatable {
  final String apiKey;
  final int page;
  final MovieKind kind;

  GetMovieUseCaseParams({
    this.apiKey = ApiConfig.API_KEY,
    this.page = 1,
    @required this.kind,
  });

  @override
  List<Object> get props => [apiKey, page, kind];
}
