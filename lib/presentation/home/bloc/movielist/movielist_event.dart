part of 'movielist_bloc.dart';

abstract class MovielistEvent extends Equatable {
  final MovieKind kind;
  MovielistEvent(this.kind);

  @override
  List<Object> get props => [kind];
}

class LoadNextMoviePageEvent extends MovielistEvent {
  LoadNextMoviePageEvent(MovieKind kind) : super(kind);
}

class RefreshMoviePageEvent extends MovielistEvent {
  RefreshMoviePageEvent(MovieKind kind) : super(kind);
}
