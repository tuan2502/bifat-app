// import 'dart:ffi';

import 'package:bifat_app/pages/HomePage.dart';
import 'package:bifat_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("TOKEN USER: ${UserCredential}");
            return const HomePage();
          } else {
            return const LoginPage();
          }
        });
  }

  Future <void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {

        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken);
        // await googleSignInAccount.reAuthCredential(credential);

        // var responseServer = await _auth.signInWithCredential(authCredential);
        // await _auth.signInWithCredential(authCredential);
        print("acccess-Token: ${googleAuth.accessToken}");
        // print("idToken: ${googleAuth.idToken}");
        // print("auth: ${await responseServer.user?.getIdToken()}");



        makeAuthServer(googleAuth.idToken.toString());
        // makeAuthenticatedRequest(googleAuth.idToken.toString());
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> saveAccessToken(String token, String refreshToken) async {
    // Save the token to storage using your preferred storage mechanism
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<String?> getAccessToken() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    return googleAuth.idToken;

  }

  Future<Map<String, String>> readTokens() async {
    final prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString('access_token') ?? '';
    final refreshToken = prefs.getString('refresh_token') ?? '';

    return {'access_token': accessToken, 'refresh_token': refreshToken};
  }

  signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  Future<String> makeAuthServer(String idToken) async {
    final String? idToken = await getAccessToken();
    if (idToken != null) {
      print("idToken: ${idToken}");
      final response = await http.post(
        Uri.parse("https://bifatlaundrybe.online/api/v1/oauth2/public/login?idToken=${idToken}"),
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );
      if (response.statusCode == 200) {
        print("success");
        print("${response.body}");
        return response.body;
      } else {
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Access token not found');
    }
  }

  // Make an authenticated API request
  Future<String> makeAuthenticatedRequest(String idToken) async {
    final String? idToken = await getAccessToken();
    if (idToken != null) {
      final response = await http.get(
        Uri.parse('https://lacha.s2tek.net/swagger/index.html'),
        headers: {
          'Authorization': 'Bearer $idToken',
        },
      );
      if (response.statusCode == 200) {
        print('Success!!!');
        return response.body;
      } else {
        throw Exception('Failed to fetch data');
      }
    } else {
      throw Exception('Access token not found');
    }
  }
}
