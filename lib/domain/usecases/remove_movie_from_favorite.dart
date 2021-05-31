import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';

class RemoveMovieFromFavoriteUseCase
    extends BaseUseCase<bool, RemoveMovieFromFavoriteParams> {
  final MovieRepository repository;

  RemoveMovieFromFavoriteUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(RemoveMovieFromFavoriteParams params) {
    return repository.removeMovieFromFavorite(params.movieId);
  }
}

class RemoveMovieFromFavoriteParams extends Equatable {
  final String movieId;

  RemoveMovieFromFavoriteParams({required this.movieId});
  @override
  List<Object> get props => [movieId];
}
