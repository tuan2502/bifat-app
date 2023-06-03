// import 'dart:ffi';
import 'dart:convert';
import 'package:bifat_app/services/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:bifat_app/pages/HomePage.dart';
import 'package:bifat_app/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../core/helpers/local_storage_helper.dart';

class FirebaseServices {
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

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential authCredential = GoogleAuthProvider.credential(
  //           accessToken: googleSignInAuthentication.accessToken,
  //           idToken: googleSignInAuthentication.idToken);
  //       await _auth.signInWithCredential(authCredential);
  //       var responseServer = await _auth.signInWithCredential(authCredential);
  //       print("Token: ${await responseServer.user?.getIdToken()}");
  //       //print("Token: ${googleSignInAuthentication.idToken}");
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  signInWithGoogle() async {
    try {
      googleSignOut();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        var responseServer = await _auth.signInWithCredential(authCredential);
        print(await responseServer.user?.getIdToken());
        //https://hqtbe.site/api/v1/oauth2/public/login?idToken=${await response.user?.getIdToken()}
        final response = await http.get(Uri.parse(
            'https://bifatlaundrybe.online/api/v1/oauth2/public/login?idToken=${await responseServer.user?.getIdToken()}'));
        if (response.statusCode == 202) {
          final json = jsonDecode(response.body);
          print("Heloo $json");
          var accessToken = json['data']['accessToken'];
          var refreshToken = json['data']['refreshToken'];
          final SharedPreferences? prefs = await _prefs;
          await prefs?.setString('accessToken', accessToken);
          await prefs?.setString('refreshToken', refreshToken);
          LocalStorageHelper.setValue('accessToken', accessToken);
          LocalStorageHelper.setValue('refreshToken', refreshToken);
          //String fcmToken = LocalStorageHelper.getValue('fcmToken');
          //savingFCMToken(fcmToken);
          return true;
        } else {
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      throw e;
    }
  }

// save fcm when user login
  void savingFCMToken(String fcmToken) async {
    try {
      String token = LocalStorageHelper.getValue('accessToken');
      var header = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map body = {"token": fcmToken};
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEngponts.savingFCMToken);
      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: header);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        print('Saving FCM token success');
      }
    } catch (e) {}
    return null;
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
