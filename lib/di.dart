import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/movie_data_mapper.dart';
import 'package:movieguide/data/repository/local/api/db/app_database.dart';
import 'package:movieguide/data/repository/local/api/db/impl/app_database_impl.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/movie_repository_impl.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/data/repository/remote/api/movie_api.dart';
import 'package:movieguide/data/repository/remote/api/service_generator.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/domain/usecases/add_movie_to_favorite_usecase.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';
import 'package:movieguide/domain/usecases/remove_movie_from_favorite.dart';
import 'domain/repository/movie_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDi() async {
  _coreModule();
  _networkModule();
  _repositoryModule();
  _usecaseModule();
}

_coreModule() {
  getIt.registerSingleton(DataConnectionChecker());
  getIt.registerSingleton<NetworkInfo>(
      NetworkInfoImpl(getIt.get<DataConnectionChecker>()));
}

_networkModule() {
  getIt.registerSingleton(ServiceGenerator.generate(ApiConfig.API_KEY, null));
  getIt.registerSingleton(MovieApi(getIt.get()));
}

_repositoryModule() {
  getIt.registerSingleton(MovieDataMaper());
  getIt.registerSingleton<AppDatabase>(AppDataBaseImpl.instance);
  getIt.registerSingleton(MovieRemoteDataSource(movieApi: getIt.get()));
  getIt.registerSingleton(MovieLocalDataSource(getIt.get()));
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl(
    remoteDataSource: getIt.get(),
    localDataSource: getIt.get(),
    networkInfo: getIt.get(),
    movieDataMapper: getIt.get(),
  ));
}

_usecaseModule() {
  getIt.registerFactory(() => GetMovieUseCase(repository: getIt.get()));
  getIt.registerFactory(
      () => AddMovieToFavoriteUseCase(repository: getIt.get()));
  getIt.registerFactory(
      () => RemoveMovieFromFavoriteUseCase(repository: getIt.get()));
}
