import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';
import 'package:movieguide/domain/usecases/load_favorite_movie_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';
import 'package:movieguide/presentation/base/base_model.dart';

class FavoriteMovieChangeNotifier extends BaseModel {
  final AddMovieToFavoriteUseCase addMovieToFavoriteUseCase;
  final RemoveMovieFromFavoriteUseCase removeMovieFromFavoriteUseCase;
  final LoadFavoriteMoviesUseCase favoriteMoviesUseCase;
  FavoriteMovieChangeNotifier({
    this.addMovieToFavoriteUseCase,
    this.removeMovieFromFavoriteUseCase,
    this.favoriteMoviesUseCase,
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
    final movies = await favoriteMoviesUseCase(NoParams());
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
