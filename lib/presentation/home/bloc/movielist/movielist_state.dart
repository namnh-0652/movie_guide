part of 'movielist_bloc.dart';

abstract class MovielistState extends Equatable {
  const MovielistState();

  @override
  List<Object> get props => [];
}

class MovielistInitial extends MovielistState {}

class MovielistLoaded extends MovielistState {
  final List<Movie> movies;
  final bool hasReachedEnd;

  MovielistLoaded({@required this.movies, @required this.hasReachedEnd});

  MovielistLoaded copyWith({List<Movie> movies, bool hasReachedEnd}) {
    return MovielistLoaded(
        movies: movies ?? this.movies,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }

  @override
  List<Object> get props => [movies, ...super.props];
}

class MovielistError extends MovielistState {
  final String errorMessage;

  MovielistError({this.errorMessage});

  @override
  List<Object> get props => [errorMessage, ...super.props];
}
