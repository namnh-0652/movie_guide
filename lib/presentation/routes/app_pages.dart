import 'package:get/get.dart';

import 'package:movieguide/presentation/pages/detail/movie_detail_binding.dart';
import 'package:movieguide/presentation/pages/detail/movie_detail_screen.dart';
import 'package:movieguide/presentation/pages/home/home_binding.dart';
import 'package:movieguide/presentation/pages/home/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const MOVIE_DETAIL = Routes.MOVIE_DETAIL;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MOVIE_DETAIL,
      page: () => MovieDetailScreen(),
      binding: MovieDetailBinding(),
    ),
  ];
}
