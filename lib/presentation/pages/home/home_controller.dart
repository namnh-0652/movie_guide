import 'package:get/get.dart';
import 'package:movieguide/data/repository/local/api/error/local_error.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/usecases/base_usecase.dart';
import 'package:movieguide/domain/usecases/load_favorite_movie_usecase.dart';
import 'package:movieguide/presentation/base/process_state.dart';
import 'package:movieguide/shared/constant.dart';

class HomeController extends GetxController {
  final LoadFavoriteMoviesUseCase loadFavoriteMoviesUseCase;
  final _favoriteState = Rx<ProcessState?>(ProcessState.loading());
  get favoriteState => this._favoriteState.value;
  set favoriteState(value) => this._favoriteState.value = value;

  final _movies = <Movie>[].obs;
  set movies(value) => this._movies.value = value;
  get movies => this._movies;

  HomeController({required this.loadFavoriteMoviesUseCase});

  @override
  void onInit() {
    _loadFavoriteMovies();
    super.onInit();
  }

  void _loadFavoriteMovies() async {
    final load = await loadFavoriteMoviesUseCase(NoParams());
    load.fold((failure) {
      _favoriteState.value = ProcessState.error(_mapErrorToString(failure));
    }, (data) {
      _movies.clear();
      _movies.addAll(data);
      _favoriteState.value = ProcessState.success(movies);
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
