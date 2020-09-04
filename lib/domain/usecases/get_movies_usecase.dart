import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';

class GetMovieUseCase
    extends BaseUseCase<Tuple2<List<Movie>, int>, GetMovieUseCaseParams> {
  final MovieRepository repository;

  GetMovieUseCase({this.repository});

  @override
  Future<Either<Failure, Tuple2<List<Movie>, int>>> call(
      GetMovieUseCaseParams params) async {
    return await repository.popularMovies(params.apiKey, params.page);
  }
}

class GetMovieUseCaseParams extends Equatable {
  final String apiKey;
  final int page;
  GetMovieUseCaseParams({this.apiKey, this.page});

  @override
  List<Object> get props => [apiKey, page];
}
