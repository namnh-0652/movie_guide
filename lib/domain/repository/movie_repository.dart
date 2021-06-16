import 'package:dartz/dartz.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/error_entity.dart';

abstract class MovieRepository {
  Future<Either<ErrorEntity, Tuple2<List<Movie>, int?>>> getMovies(
    String apiKey,
    int page,
    MovieKind kind,
  );
  Future<Either<ErrorEntity, List<Movie>>> loadFavoriteMovies();
  Future<Either<ErrorEntity, bool>> addMovieToFavorite(Movie movie);
  Future<Either<ErrorEntity, bool>> removeMovieFromFavorite(String movieId);
  Future<Either<ErrorEntity, MovieDetail>> getMovieDetail(
    String apiKey,
    int movieId,
  );
}
