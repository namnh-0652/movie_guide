import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/entities/movie_kind.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';

part 'movielist_event.dart';
part 'movielist_state.dart';

const String NETWORK_ERROR = "No network available, please check!";
const String SERVER_ERROR = "Can not retrieve data from server";
const String UNEXPECTED_ERROR = "Unexpected Error";

class MovielistBloc extends Bloc<MovielistEvent, MovielistState> {
  final GetMovieUseCase getMovieUseCase;
  int? _nextPage = 1;
  bool _isLoading = false;

  MovielistBloc({required this.getMovieUseCase}) : super(MovielistInitial());

  @override
  void onTransition(Transition<MovielistEvent, MovielistState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<MovielistState> mapEventToState(
    MovielistEvent event,
  ) async* {
    final currentState = state;
    if (event is LoadNextMoviePageEvent && !_hasReachedEnd(currentState)) {
      _isLoading = true;
      final eitherMovies = await getMovieUseCase(GetMovieUseCaseParams(
          apiKey: ApiConfig.API_KEY, page: _nextPage ?? 1, kind: event.kind));
      yield eitherMovies.fold(
        (failure) => MovielistError(errorMessage: _mapValueToString(failure)),
        (data) {
          _nextPage = data.value2;
          if (currentState is MovielistLoaded) {
            return _nextPage == null
                ? currentState.copyWith(hasReachedEnd: true)
                : MovielistLoaded(
                    movies: currentState.movies + data.value1,
                    hasReachedEnd: false);
          }
          return MovielistLoaded(movies: data.value1, hasReachedEnd: false);
        },
      );
      _isLoading = false;
    } else if (event is RefreshMoviePageEvent) {
      _nextPage = 1;
      fectchMovies(event.kind);
    }
  }

  bool _hasReachedEnd(MovielistState currentState) {
    return currentState is MovielistLoaded && currentState.hasReachedEnd;
  }

  bool get isLoading => _isLoading;

  String _mapValueToString(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return NETWORK_ERROR;
      case ServerFailure:
        return SERVER_ERROR;
      case CacheFailue:
      default:
        return UNEXPECTED_ERROR;
    }
  }

  Future<void> refresh(MovieKind kind) async {
    add(RefreshMoviePageEvent(kind));
  }

  Future<void> fectchMovies(MovieKind kind) async {
    add(LoadNextMoviePageEvent(kind));
  }
}
