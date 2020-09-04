import 'package:dartz/dartz.dart';
import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/repository/remote/api/movie_api.dart';

class MovieRemoteDataSource {
  final MovieApi movieApi;
  MovieRemoteDataSource({this.movieApi});

  Future<Tuple2<List<MovieData>, int>> popularMovies(
      String apiKey, int page) async {
    final response = await movieApi.popularMovies(apiKey, page);
    return Tuple2(response.results, response.nextPage);
  }
}
