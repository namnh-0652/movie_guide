import 'package:dartz/dartz.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';

import 'base_usecase.dart';

class LoadFavoriteMoviesUseCase extends BaseUseCase<List<Movie>, NoParams> {
  final MovieRepository repository;

  LoadFavoriteMoviesUseCase({required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return repository.loadFavoriteMovies();
  }
}
