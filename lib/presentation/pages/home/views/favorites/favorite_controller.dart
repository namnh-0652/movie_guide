import 'package:get/get.dart';
import 'package:movieguide/data/repository/local/api/error/local_error.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';
import 'package:movieguide/presentation/base/process_state.dart';
import 'package:movieguide/shared/constant.dart';

import '../../home_controller.dart';

class FavoriteController extends GetxController {
  final AddMovieToFavoriteUseCase addMovieToFavoriteUseCase;
  final RemoveMovieFromFavoriteUseCase removeMovieFromFavoriteUseCase;
  final HomeController _homeController = Get.find();

  FavoriteController({
    required this.addMovieToFavoriteUseCase,
    required this.removeMovieFromFavoriteUseCase,
  });

  get movies => _homeController.movies;

  void addToFavorite(Movie movie) async {
    final add =
        await addMovieToFavoriteUseCase(AddMovieToFavoriteParams(movie: movie));
    add.fold((failure) {
      _homeController.favoriteState =
          ProcessState.error(_mapErrorToString(failure));
    }, (data) {
      _homeController.movies.add(movie);
      _homeController.favoriteState = ProcessState.success(movies);
    });
  }

  void removeFromFavorite(Movie movie) async {
    final remove = await removeMovieFromFavoriteUseCase(
      RemoveMovieFromFavoriteParams(movieId: movie.id.toString()),
    );
    remove.fold((failure) {
      _homeController.favoriteState =
          ProcessState.error(_mapErrorToString(failure));
    }, (data) {
      _homeController.movies.remove(movie);
      _homeController.favoriteState = ProcessState.success(movies);
    });
  }

  String _mapErrorToString(ErrorEntity failure) {
    switch (failure.runtimeType) {
      case DatabaseError:
        return DATABASE_ERROR;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}
