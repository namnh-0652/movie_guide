import 'package:dartz/dartz.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, Tuple2<List<Movie>, int>>> getMovies(
      String apiKey, int page, MovieKind kind);
}
