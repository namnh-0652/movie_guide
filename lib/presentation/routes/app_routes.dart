part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const MOVIE_DETAIL = _Paths.MOVIE_DETAIL;
}

abstract class _Paths {
  static const HOME = '/';
  static const MOVIE_DETAIL = "/detail";
}
