import 'package:get/get.dart';
import 'home_controller.dart';
import 'views/favorites/favorite_controller.dart';
import 'views/newest/newest_controller.dart';
import 'views/popular/popular_controller.dart';
import 'views/rated/rated_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(loadFavoriteMoviesUseCase: Get.find()));
    Get.lazyPut(() => NewestController(getMovieUseCase: Get.find()));
    Get.lazyPut(() => PopularController(getMovieUseCase: Get.find()));
    Get.lazyPut(() => RatedController(getMovieUseCase: Get.find()));
    Get.lazyPut(
      () => FavoriteController(
        addMovieToFavoriteUseCase: Get.find(),
        removeMovieFromFavoriteUseCase: Get.find(),
      ),
    );
  }
}
