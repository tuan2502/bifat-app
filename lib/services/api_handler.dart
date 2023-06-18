import 'dart:convert';
import 'dart:math';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/services_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHandler {

  static Future postDataToWallet(double amount) async {
    var token = await FirebaseServices.getAccessToken();
    String returnUrl = 'https://www.bifatlaundry.website/';
    var dataInput = jsonEncode(<String, dynamic>{
      'amount': amount,
      'returnUrl': returnUrl,
    });
    final url = Uri.parse(
        '${BASE_URL}/transaction/wallet/deposit');
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
      var urlVnpay = jsonDecode(response.body)['data'];
      print('urlVnpay1: $urlVnpay');
      return urlVnpay;
    } else {
      print('API post failed');
    }
  }


}
