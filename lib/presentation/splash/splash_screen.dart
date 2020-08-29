import 'dart:async';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieguide/presentation/router.dart';
import 'package:movieguide/shared/constant.dart';

class SplashScreen extends StatelessWidget {
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
