// import 'dart:ffi';
import 'dart:convert';
import 'package:bifat_app/services/utils/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:bifat_app/page/home/HomePage.dart';
import 'package:bifat_app/page/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../core/helpers/local_storage_helper.dart';

class FirebaseServices {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("TOKEN USER: $UserCredential");
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
      signOut();
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        var responseServer = await _auth.signInWithCredential(authCredential);
        // print(await responseServer.user?.getIdToken());
        //https://hqtbe.site/api/v1/oauth2/public/login?idToken=${await response.user?.getIdToken()}
        final String? idToken = await responseServer.user?.getIdToken();
        final response = await http.get(
          Uri.parse(
              'https://bifatlaundrybe.online/api/v1/oauth2/public/login?idToken=$idToken'),
        );
        if (response.statusCode == 202) {
          final json = jsonDecode(response.body);
          // print("Heloo $json");
          var accessToken = json['data']['accessToken'];
          var refreshToken = json['data']['refreshToken'];
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('refreshToken', refreshToken);
          LocalStorageHelper.setValue('accessToken', accessToken);
          LocalStorageHelper.setValue('refreshToken', refreshToken);
          return true;
        } else {
          return false;
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      rethrow;
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

  static getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');
    print('token: $token');
    return token;
  }

  static getServiceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var serviceId = prefs.getString('serviceId');
    // print('serviceId: $serviceId');
    return serviceId;
  }

  static getVoucherId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var voucherId = prefs.getString('voucherId');
    print('voucherId: $voucherId');
    return voucherId;
  }
}

//Voucher....
class FirebaseVouchers {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            print("TOKEN USER: $UserCredential");
            return const HomePage();
          } else {
            return const LoginPage();
          }
        });
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
        var responseServer = await _auth.signInWithCredential(authCredential);
        print("Token: ${await responseServer.user?.getIdToken()}");
        //print("Token: ${googleSignInAuthentication.idToken}");
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');
    // print('token: $token');
    return token;
  }

  static getVoucherId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var voucherId = prefs.getString('voucherId');
    // print('voucherId: $voucherId');
    return voucherId;
  }

  static getUrlVnpay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var urlVnpay = prefs.getString('urlVnpay');
    print('urlVnpay: $urlVnpay');
    return urlVnpay;
  }
}
