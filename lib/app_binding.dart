import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/core/platform/network_info_impl.dart';
import 'package:movieguide/data/model/mapper/movie_data_mapper.dart';
import 'package:movieguide/data/model/mapper/movie_detail_mapper.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/movie_repository_impl.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/domain/repository/movie_repository.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';
import 'package:movieguide/domain/usecases/load_favorite_movie_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';

import 'data/repository/remote/api/api_config.dart';
import 'data/repository/remote/api/middleware/connectivity_interceptor.dart';
import 'data/repository/remote/api/movie_api.dart';
import 'data/repository/remote/api/service_generator.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    _coreModule();
    _networkModule();
    _mapperModule();
    _repositoryModule();
    _usecaseModule();
  }

  _coreModule() {
    Get.lazyPut<Connectivity>(() => Connectivity());
    Get.lazyPut<NetworkInfo>(() => NetworkInfoImpl(Get.find()));
  }

  _networkModule() {
    Get.lazyPut(
      () => ServiceGenerator.generate(
        ApiConfig.API_KEY,
        inteceptors: [ConnectivityInterceptor(Get.find()), LogInterceptor()],
      ),
    );

    Get.lazyPut(() => MovieApi(Get.find()));
  }

  _mapperModule() {
    Get.lazyPut(() => MovieDataMaper(), fenix: true);
    Get.lazyPut(() => MovieDetailMapper(), fenix: true);
  }

  _repositoryModule() {
    //Get.lazyPut<AppDatabase>(() => AppDataBaseImpl.instance);
    Get.lazyPut(() => MovieRemoteDataSource(Get.find()));
    Get.lazyPut(() => MovieLocalDataSource(Get.find()));
    Get.lazyPut<MovieRepository>(
      () => MovieRepositoryImpl(
        remoteDataSource: Get.find(),
        localDataSource: Get.find(),
        movieDataMapper: Get.find(),
        movieDetailMapper: Get.find(),
      ),
    );
  }

  _usecaseModule() {
    Get.lazyPut(() => GetMovieUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => AddMovieToFavoriteUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => RemoveMovieFromFavoriteUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadFavoriteMoviesUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => GetMovieDetailUseCase(Get.find()), fenix: true);
  }
}
