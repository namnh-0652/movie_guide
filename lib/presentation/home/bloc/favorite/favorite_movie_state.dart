part of 'favorite_movie_cubit.dart';

abstract class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

class FavoriteMovieInitial extends FavoriteMovieState {}

class AddedToFavorite extends FavoriteMovieState {}

class RemovedFromFavorite extends FavoriteMovieState {}

class ActionFavoriteError extends FavoriteMovieState {}
