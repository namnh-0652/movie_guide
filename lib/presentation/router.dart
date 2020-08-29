import 'package:flutter/material.dart';
import 'package:movieguide/presentation/home/home_screen.dart';
import 'package:movieguide/presentation/splash/splash_screen.dart';

class Router {
  static const String splashRoute = "/";
  static const String homeRoute = "/home";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case homeRoute:
        final title = settings.arguments;
        return MaterialPageRoute(builder: (_) => HomeScreen(title: title));
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
