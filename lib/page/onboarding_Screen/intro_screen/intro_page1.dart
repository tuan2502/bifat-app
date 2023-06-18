import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({
    super.key,
    required this.color,
    required this.imgPath,
  });
  final MaterialAccentColor color;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.pinkAccent,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imgPath,
            height: 250,
            width: 300,
          ),
        ],
      ),
    );
  }
}
