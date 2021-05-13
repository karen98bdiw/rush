import 'package:flutter/material.dart';

class AppInScreenLogo extends StatelessWidget {
  final BoxConstraints parentContstaits;

  AppInScreenLogo({this.parentContstaits});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/trivia_icon.png",
      height: parentContstaits.maxHeight * 0.2,
      fit: BoxFit.fitHeight,
    );
  }
}
