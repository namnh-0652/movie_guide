import 'package:movieguide/data/model/movie_data.dart';
import 'api/db/app_database.dart';

class MovieLocalDataSource {
  final AppDatabase appDatabase;
  MovieLocalDataSource(this.appDatabase);

  Future<int> addMovieToFavorite(MovieData movie) {
    return appDatabase.movieDao().insert(movie);
  }

  Future<List<MovieData>> loadFavoriteMovies() {
    return appDatabase.movieDao().getAll();
  }

  Future<int> removeMovieFromFavorite(String movieId) {
    return appDatabase.movieDao().deleteById(int.parse(movieId));
  }
}
