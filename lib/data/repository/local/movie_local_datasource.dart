import 'package:movieguide/data/model/movie_data.dart';
import 'api/db/app_database.dart';
import 'api/local_api_ext.dart';

class MovieLocalDataSource {
  final AppDatabase appDatabase;
  MovieLocalDataSource(this.appDatabase);

  Future<int> addMovieToFavorite(MovieData movie) {
    return appDatabase.execute((db) {
      return db.movieDao().insert(movie);
    });
  }

  Future<List<MovieData>> loadFavoriteMovies() {
    return appDatabase.execute((db) {
      return db.movieDao().getAll();
    });
  }

  Future<int> removeMovieFromFavorite(String movieId) {
    return appDatabase.execute((db) {
      return db.movieDao().deleteById(int.parse(movieId));
    });
  }
}
