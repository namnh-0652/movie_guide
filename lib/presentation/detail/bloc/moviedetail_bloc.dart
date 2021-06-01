import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/domain/entities/movie_detail.dart';
import 'package:movieguide/domain/error/failure.dart';
import 'package:movieguide/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movieguide/presentation/home/bloc/movielist/movielist_bloc.dart';

part 'moviedetail_event.dart';
part 'moviedetail_state.dart';

class MoviedetailBloc extends Bloc<MoviedetailEvent, MoviedetailState> {
  final GetMovieDetailUseCase movieDetailUseCase;
  MoviedetailBloc({required this.movieDetailUseCase})
      : super(MoviedetailInitial());

  @override
  Stream<MoviedetailState> mapEventToState(
    MoviedetailEvent event,
  ) async* {
    if (event is! GetMovieDetailEvent) return;
    final response = await movieDetailUseCase(
      GetMovieDetailUseCaseParams(
        apiKey: ApiConfig.API_KEY,
        movieId: event.movieId,
      ),
    );

    yield response.fold(
        (failure) => MoviedetailError(errorMessage: _mapValueToString(failure)),
        (data) => MoviedetailLoaded(movieDetail: data));
  }

  String _mapValueToString(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure:
        return NETWORK_ERROR;
      case ServerFailure:
        return SERVER_ERROR;
      case CacheFailure:
      default:
        return UNEXPECTED_ERROR;
    }
  }
}
