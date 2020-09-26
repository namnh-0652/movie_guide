part of 'moviedetail_bloc.dart';

abstract class MoviedetailEvent extends Equatable {
  const MoviedetailEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailEvent extends MoviedetailEvent {
  final int movieId;
  const GetMovieDetailEvent({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
