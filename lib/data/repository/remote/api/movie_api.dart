import 'package:movieguide/data/model/movie_data.dart';
import 'package:movieguide/data/model/movie_detail_data.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/data/repository/remote/response/paged_response.dart';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
part 'movie_api.g.dart';

@RestApi(baseUrl: ApiConfig.BASE_URL)
abstract class MovieApi {
  factory MovieApi(Dio dio, {String baseUrl}) = _MovieApi;

  @GET("/movie/popular")
  Future<PagedResponse<MovieData>> popularMovies(
      @Query("api_key") String apiKey, @Query("page") int page);

  @GET("/movie/top_rated")
  Future<PagedResponse<MovieData>> ratedMovies(
      @Query("api_key") String apiKey, @Query("page") int page);

  @GET("/movie/upcoming")
  Future<PagedResponse<MovieData>> latestMovies(
      @Query("api_key") String apiKey, @Query("page") int page);

  @GET("/movie/{movie_id}")
  Future<MovieDetailData> getMovieDetail(
      @Query("api_key") String apiKey, @Path("movie_id") int movieId);
}
