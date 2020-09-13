import 'dao/movie_dao.dart';

abstract class AppDatabase {
  Future<void> init();
  MovieDao movieDao();
}
