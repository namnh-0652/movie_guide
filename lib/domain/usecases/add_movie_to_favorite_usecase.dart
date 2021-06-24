import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';

class AddMovieToFavoriteUseCase
    extends BaseUseCase<bool, AddMovieToFavoriteParams> {
  final MovieRepository repository;

  AddMovieToFavoriteUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, bool>> call(AddMovieToFavoriteParams params) {
    return repository.addMovieToFavorite(params.movie);
  }
}

class AddMovieToFavoriteParams extends Equatable {
  final Movie movie;

  AddMovieToFavoriteParams({required this.movie});
  @override
  List<Object> get props => [movie];
}
