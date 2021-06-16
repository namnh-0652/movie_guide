import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';
import 'package:movieguide/domain/usecases/load_favorite_movie_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';
import 'package:movieguide/presentation/base/base_model.dart';

class FavoriteMovieChangeNotifier extends BaseModel {
  final AddMovieToFavoriteUseCase addMovieToFavoriteUseCase;
  final RemoveMovieFromFavoriteUseCase removeMovieFromFavoriteUseCase;
  final LoadFavoriteMoviesUseCase loadFavoriteMoviesUseCase;
  FavoriteMovieChangeNotifier({
    required this.addMovieToFavoriteUseCase,
    required this.removeMovieFromFavoriteUseCase,
    required this.loadFavoriteMoviesUseCase,
  });

  final List<Movie> _favoriteMovies = [];
  List<Movie> get favoriteMovies => _favoriteMovies;

  void addToFavorite(Movie movie) async {
    setViewState(ViewState.Busy);
    final add =
        await addMovieToFavoriteUseCase(AddMovieToFavoriteParams(movie: movie));
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
    final remove = await removeMovieFromFavoriteUseCase(
      RemoveMovieFromFavoriteParams(movieId: movie.id.toString()),
    );
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
    final movies = await loadFavoriteMoviesUseCase(NoParams());
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
