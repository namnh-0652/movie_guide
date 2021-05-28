import 'package:flutter/material.dart';
import 'package:movieguide/presentation/home/home_screen.dart';

class Routers {
  static const String homeRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
