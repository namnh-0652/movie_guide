import 'package:flutter/material.dart';

class BottomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15),
    );
  }
}
