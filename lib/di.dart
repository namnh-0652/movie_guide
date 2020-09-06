import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:movieguide/core/platform/network_info.dart';
import 'package:movieguide/data/model/mapper/data_mapper.dart';
import 'package:movieguide/data/repository/local/movie_local_datasource.dart';
import 'package:movieguide/data/repository/movie_repository_impl.dart';
import 'package:movieguide/data/repository/remote/api/api_config.dart';
import 'package:movieguide/data/repository/remote/api/movie_api.dart';
import 'package:movieguide/data/repository/remote/api/service_generator.dart';
import 'package:movieguide/data/repository/remote/movie_remote_datasource.dart';
import 'package:movieguide/domain/usecases/get_movies_usecase.dart';

import 'domain/repository/movie_repository.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
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
  getIt.registerSingleton(MovieRemoteDataSource(movieApi: getIt.get()));
  getIt.registerSingleton(MovieLocalDataSource());
  getIt.registerSingleton(DataMapper());
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl(
    remoteDataSource: getIt.get(),
    localDataSource: getIt.get(),
    networkInfo: getIt.get(),
    dataMapper: getIt.get(),
  ));
}

_usecaseModule() {
  getIt.registerFactory(() => GetMovieUseCase(repository: getIt.get()));
}
