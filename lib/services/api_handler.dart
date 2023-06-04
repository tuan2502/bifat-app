

import 'dart:convert';
import 'dart:math';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/services_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;


class ApiHandler {

  /*
  * API lấy toàn bộ services
  */

  static Future<List<dynamic>> getAllData() async {
    try {
      var token = await FirebaseServices.getAccessToken();
      http.Response response;
      response = await http.get(
        Uri.parse('${BASE_URL}service'),
        headers: {'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',});
      var data = jsonDecode(response.body);
      List tempList = [];
      print(data["data"]);
      return tempList;
    } catch (e) {
      print('An error occurred1 $e');
      throw e.toString();
    }
  }
}