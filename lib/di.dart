import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/movie_data_mapper.dart';
import 'package:movieguide/data/model/mapper/movie_detail_mapper.dart';
import 'package:movieguide/data/repository/local/api/db/app_database.dart';
import 'package:movieguide/data/repository/local/api/db/impl/app_database_impl.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/movie_repository_impl.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/data/repository/remote/api/movie_api.dart';
import 'package:movieguide/data/repository/remote/api/service_generator.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/get_movie_detail_usecase.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';
import 'package:movieguide/domain/usecases/load_favorite_movie_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';
import 'core/platform/network_info_impl.dart';
import 'domain/repository/movie_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDi() async {
  _coreModule();
  _networkModule();
  _mapperModule();
  _repositoryModule();
  _usecaseModule();
}

_coreModule() {
  getIt.registerSingleton(Connectivity());
  getIt.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(getIt.get<Connectivity>()),
  );
}

_networkModule() {
  getIt.registerSingleton(ServiceGenerator.generate(ApiConfig.API_KEY, null));
  getIt.registerSingleton(MovieApi(getIt.get()));
}

_mapperModule() {
  getIt.registerSingleton(MovieDataMaper());
  getIt.registerSingleton(MovieDetailMapper());
}

_repositoryModule() {
  getIt.registerSingleton<AppDatabase>(AppDataBaseImpl.instance);
  getIt.registerSingleton(MovieRemoteDataSource(movieApi: getIt.get()));
  getIt.registerSingleton(MovieLocalDataSource(getIt.get()));
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl(
    remoteDataSource: getIt.get(),
    localDataSource: getIt.get(),
    networkInfo: getIt.get(),
    movieDataMapper: getIt.get(),
    movieDetailMapper: getIt.get(),
  ));
}

_usecaseModule() {
  getIt.registerFactory(() => GetMovieUseCase(repository: getIt.get()));
  getIt.registerFactory(
    () => AddMovieToFavoriteUseCase(repository: getIt.get()),
  );
  getIt.registerFactory(
    () => RemoveMovieFromFavoriteUseCase(repository: getIt.get()),
  );
  getIt.registerFactory(
    () => LoadFavoriteMoviesUseCase(repository: getIt.get()),
  );
  getIt.registerFactory(() => GetMovieDetailUseCase(repository: getIt.get()));
}
