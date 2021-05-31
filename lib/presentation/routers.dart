import 'package:flutter/material.dart';
import 'package:movieguide/presentation/detail/movie_detail_screen.dart';
import 'package:movieguide/presentation/home/home_screen.dart';

class Routers {
  static const String homeRoute = "/";
  static const String detailRoute = "/detail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        final title = settings.arguments?.toString();
        return MaterialPageRoute(builder: (_) => HomeScreen(title: title));
      case detailRoute:
        final args = settings.arguments as Map;
        final title = args['title'];
        final movieId = args['movieId'];
        final heroImageURL = args['heroImageURL'];
        final heroImageTag = args['heroImageTag'];

        return MaterialPageRoute(
          builder: (_) => MovieDetailScreen(
            title: title,
            movieId: movieId,
            heroImageURL: heroImageURL,
            heroImageTag: heroImageTag,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
