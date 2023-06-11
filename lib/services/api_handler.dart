import 'dart:convert';
import 'dart:math';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/services_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHandler {
  static Future<List<dynamic>> getAllData() async {
    try {
      var token = await FirebaseServices.getAccessToken();
      http.Response response;
      response = await http.get(Uri.parse('${BASE_URL}service'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var data = jsonDecode(response.body);
      List tempList = [];
      // print(data["data"]);
      return tempList;
    } catch (e) {
      print('An error occurred1 $e');
      throw e.toString();
    }
  }

  static Future postDataToWallet(double amount, String returnUrl) async {
    var token = await FirebaseServices.getAccessToken();
    var dataInput = jsonEncode(<String, dynamic>{
      'amount': amount,
      'returnUrl': returnUrl,
    });
    final url = Uri.parse(
        'https://bifatlaundrybe.online/api/v1/transaction/wallet/vnPay');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: dataInput,
    );
    if (response.statusCode == 200) {
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      var urlVnpay = jsonDecode(response.body)['data'];
      print('urlVnpay1: $urlVnpay');
      return urlVnpay;
    } else {
      print('API call failed');
    }
  }
}
