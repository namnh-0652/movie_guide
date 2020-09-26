import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movieguide/domain/entities/movie.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';

part 'favorite_movie_state.dart';

class FavoriteMovieCubit extends Cubit<FavoriteMovieState> {
  final AddMovieToFavoriteUseCase addToFavoriteUsecase;
  final RemoveMovieFromFavoriteUseCase removeMovieFromFavoriteUseCase;

  FavoriteMovieCubit(
      this.addToFavoriteUsecase, this.removeMovieFromFavoriteUseCase)
      : super(FavoriteMovieInitial());

  void addToFavorite(Movie movie) async {
    final response =
        await addToFavoriteUsecase(AddMovieToFavoriteParams(movie: movie));
    response.fold((failure) => emit(ActionFavoriteError()),
        (data) => emit(AddedToFavorite()));
  }

  void removedFromFavorite(String movieId) async {
    final response = await removeMovieFromFavoriteUseCase(
        RemoveMovieFromFavoriteParams(movieId: movieId));
    response.fold((failure) => emit(ActionFavoriteError()),
        (data) => emit(RemovedFromFavorite()));
  }
}
