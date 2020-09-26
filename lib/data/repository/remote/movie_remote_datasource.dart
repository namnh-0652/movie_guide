import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/model/movie_detail_data.dart';
import 'package:movieguide/data/repository/remote/api/movie_api.dart';
import 'package:movieguide/data/repository/remote/response/paged_response.dart';

class MovieRemoteDataSource {
  final MovieApi movieApi;
  MovieRemoteDataSource({required this.movieApi});

  Future<PagedResponse<MovieData>> popularMovies(
      String apiKey, int page) async {
    return movieApi.popularMovies(apiKey, page);
  }

  Future<PagedResponse<MovieData>> ratedMovies(String apiKey, int page) async {
    return movieApi.ratedMovies(apiKey, page);
  }

  Future<PagedResponse<MovieData>> latestMovies(String apiKey, int page) async {
    return movieApi.latestMovies(apiKey, page);
  }

  Future<MovieDetailData> getMovieDetail(String apiKey, int movieId) async {
    return await movieApi.getMovieDetail(apiKey, movieId);
  }
}
