import 'dart:async';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieguide/presentation/home/provider/favorite_movie_notifier.dart';
import 'package:movieguide/presentation/router.dart';
import 'package:movieguide/shared/constant.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteMovieChangeNotifier>().loadFavoriteMovies();
  }

  _startTimer(BuildContext context) async {
    return Timer(Duration(seconds: 1), () {
      Navigator.of(context)
          .pushReplacementNamed(Router.homeRoute, arguments: "Home");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          child: ColorizeAnimatedTextKit(
              onFinished: () {
                _startTimer(context);
              },
              text: [APP_NAME_FOR_DISPLAYING],
              textStyle: GoogleFonts.monoton(
                fontSize: 48,
                fontWeight: FontWeight.w100,
              ),
              totalRepeatCount: 2,
              colors: [
                Colors.purple,
                Colors.blue,
                Colors.yellow,
                Colors.red,
              ],
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart),
        ),
      ),
    );
  }
}
