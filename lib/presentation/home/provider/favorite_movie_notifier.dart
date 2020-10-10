import 'package:movieguide/di.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/presentation/base/base_model.dart';

class FavoriteMovieChangeNotifier extends BaseModel {
  final MovieRepository _movieRepository = getIt.get<MovieRepository>();

  final List<Movie> _favoriteMovies = [];
  List<Movie> get favoriteMovies => _favoriteMovies;

  void addToFavorite(Movie movie) async {
    setViewState(ViewState.Busy);
    final add = await _movieRepository.addMovieToFavorite(movie);
    add.fold((l) {
      // TODO: Handle failure
      notifyListeners();
    }, (r) {
      _favoriteMovies.add(movie);
      notifyListeners();
    });
    setViewState(ViewState.Idle);
  }

  void removeFromFavorite(Movie movie) async {
    setViewState(ViewState.Busy);
    final remove =
        await _movieRepository.removeMovieFromFavorite(movie.id.toString());
    remove.fold((l) {
      // TODO: Handle failure
      notifyListeners();
    }, (r) {
      _favoriteMovies.remove(movie);
      notifyListeners();
    });
    setViewState(ViewState.Idle);
  }

  void loadFavoriteMovies() async {
    final movies = await _movieRepository.loadFavoriteMovies();
    movies.fold((l) {
      // TODO: Handle failure
      notifyListeners();
    }, (r) {
      _favoriteMovies.clear();
      _favoriteMovies.addAll(r);
      notifyListeners();
    });
  }
}
