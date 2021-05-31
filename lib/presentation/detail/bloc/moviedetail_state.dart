part of 'moviedetail_bloc.dart';

abstract class MoviedetailState extends Equatable {
  const MoviedetailState();

  @override
  List<Object> get props => [];
}

class MoviedetailInitial extends MoviedetailState {}

class MoviedetailLoaded extends MoviedetailState {
  final MovieDetail? movieDetail;

  MoviedetailLoaded({this.movieDetail});

  @override
  List<Object> get props =>
      movieDetail == null ? [super.props] : [movieDetail!, ...super.props];
}

class MoviedetailError extends MoviedetailState {
  final String? errorMessage;

  MoviedetailError({this.errorMessage});

  @override
  List<Object> get props =>
      errorMessage == null ? [super.props] : [errorMessage!, ...super.props];
}
