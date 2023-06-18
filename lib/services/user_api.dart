import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/user_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserApi with ChangeNotifier {

  //get UserApi
  static Future<UserModel> fetchUser() async {
    var token = await FirebaseServices.getAccessToken();
    const url = '$BASE_URL/users/access-token/information';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'];
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('wallet', data['balance']);
    return UserModel.fromJson(data);
  }
  // static getWallet() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var wallet = prefs.getString('wallet');
  //   print('wallet: $wallet');
  //   return wallet;
  // }
}
