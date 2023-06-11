import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '404 - Page not found',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}