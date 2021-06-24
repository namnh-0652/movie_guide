import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/data/repository/remote/api/error/api_error.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/error_entity.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';
import 'package:movieguide/presentation/base/process_state.dart';
import 'package:movieguide/shared/constant.dart';

class PopularController extends GetxController {
  final ScrollController scrollController = ScrollController();
  final GetMovieUseCase getMovieUseCase;

  PopularController({required this.getMovieUseCase});

  final _getMovieState = Rx<ProcessState?>(ProcessState.loading());
  get getMovieState => this._getMovieState.value;
  set getMovieState(value) => this._getMovieState.value = value;

  final _nextPage = Rx<int?>(1);
  set nextPage(value) => this._nextPage.value = value;
  get nextPage => this._nextPage.value;

  final _movies = <Movie>[].obs;
  set movies(value) => this._movies.value = value;
  get movies => this._movies;

  final _hasReachedEnd = false.obs;
  get hasReachedEnd => this._hasReachedEnd.value;
  set hasReachedEnd(value) => this._hasReachedEnd.value = value;

  Future<void> _getPopularMovies() async {
    if (hasReachedEnd) return;
    getMovieState = ProcessState.loading();
    final eitherMovies = await getMovieUseCase(
      GetMovieUseCaseParams(
          apiKey: ApiConfig.API_KEY,
          page: nextPage ?? 1,
          kind: MovieKind.popular),
    );
    eitherMovies.fold(
      (failure) {
        getMovieState = ProcessState.error(_mapErrorToString(failure));
      },
      (data) {
        _movies.addAll(data.value1);
        if (data.value2 == null) {
          _hasReachedEnd.value = (true);
          return;
        }
        _nextPage.value = (data.value2);
        getMovieState = ProcessState.success(movies);
      },
    );
  }

  String _mapErrorToString(ErrorEntity failure) {
    switch (failure.runtimeType) {
      case NetworkError:
        return NETWORK_ERROR;
      case ServerError:
        return SERVER_ERROR;
      default:
        return UNEXPECTED_ERROR;
    }
  }

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    _getPopularMovies();
  }

  @override
  void dispose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    double delta = 200.0;
    if (currentScroll >= maxScroll - delta && !getMovieState.isLoading) {
      _getPopularMovies();
    }
  }

  Future<void> onRefresh() async {
    _hasReachedEnd.value = (false);
    _nextPage.value = (1);
    _getPopularMovies();
  }
}
