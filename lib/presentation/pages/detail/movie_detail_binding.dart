import 'package:get/get.dart';
import 'movie_detail_controller.dart';

class MovieDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MovieDetailController(getMovieDetailUseCase: Get.find()));
  }
}
