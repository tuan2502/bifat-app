import 'package:flutter/material.dart';

class Page404 extends StatelessWidget {
  const Page404({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '404 - Page not found',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
