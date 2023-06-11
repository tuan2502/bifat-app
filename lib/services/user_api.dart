import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/user_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class UserApi with ChangeNotifier {
  
  //get UserApi
  static Future<List<UserModel>> fetchUser() async {
    var token = await FirebaseServices.getAccessToken();
    List tempList = [];
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
    tempList.add(data);
    // print('tempList: $tempList');
    final user = tempList.map((e) {
      return UserModel.fromJson(e);
    }).toList();
    return user;
  }
}
