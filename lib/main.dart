import 'package:flutter/material.dart';
import 'package:movieguide/presentation/home/provider/favorite_movie_notifier.dart';
import 'package:movieguide/presentation/router.dart';
import 'package:provider/provider.dart';

import 'data/repository/local/api/db/app_database.dart';
import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  await getIt.get<AppDatabase>().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteMovieChangeNotifier(),
      child: MaterialApp(
        title: 'Movie Guide',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: Router.splashRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
