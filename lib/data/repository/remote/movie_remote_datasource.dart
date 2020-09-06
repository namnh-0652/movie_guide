import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/repository/remote/api/movie_api.dart';

class MovieRemoteDataSource {
  final MovieApi movieApi;
  MovieRemoteDataSource({@required this.movieApi});

  Future<Tuple2<List<MovieData>, int>> popularMovies(
      String apiKey, int page) async {
    final response = await movieApi.popularMovies(apiKey, page);
    return Tuple2(response.results, response.nextPage);
  }

  Future<Tuple2<List<MovieData>, int>> ratedMovies(
      String apiKey, int page) async {
    final response = await movieApi.ratedMovies(apiKey, page);
    return Tuple2(response.results, response.nextPage);
  }

  Future<Tuple2<List<MovieData>, int>> latestMovies(
      String apiKey, int page) async {
    final response = await movieApi.latestMovies(apiKey, page);
    return Tuple2(response.results, response.nextPage);
  }
}
