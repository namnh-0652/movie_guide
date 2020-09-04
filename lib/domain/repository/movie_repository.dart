import 'package:dartz/dartz.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/failure.dart';

abstract class MovieRepository {
  Future<Either<Failure, Tuple2<List<Movie>, int>>> popularMovies(
      String apiKey, int page);
}
