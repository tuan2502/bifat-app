import 'package:bifat_app/page/home/HomePage.dart';
import 'package:bifat_app/page/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              //user is logged in
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return LoginPage();
              }
            }));
  }
}
