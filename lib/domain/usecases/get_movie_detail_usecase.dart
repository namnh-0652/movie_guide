import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';

class GetMovieDetailUseCase
    extends BaseUseCase<MovieDetail, GetMovieDetailUseCaseParams> {
  final MovieRepository repository;

  GetMovieDetailUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, MovieDetail>> call(
      GetMovieDetailUseCaseParams params) {
    return repository.getMovieDetail(params.apiKey, params.movieId);
  }
}

class GetMovieDetailUseCaseParams extends Equatable {
  final String apiKey;
  final int movieId;

  GetMovieDetailUseCaseParams({
    required this.apiKey,
    required this.movieId,
  });

  @override
  List<Object> get props => [apiKey, movieId];
}
