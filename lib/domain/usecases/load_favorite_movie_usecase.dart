import 'package:dartz/dartz.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';

import 'base_usecase.dart';

class LoadFavoriteMoviesUseCase extends BaseUseCase<List<Movie>, NoParams> {
  final MovieRepository repository;

  LoadFavoriteMoviesUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, List<Movie>>> call(NoParams params) {
    return repository.loadFavoriteMovies();
  }
}
