

import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/services_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;


class BifatApi{

  /*
  * API lấy toàn bộ services
  */

  static Future<List<ServicesModel>> getAllServices() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    http.Response response;
    response = await http.get(
        Uri.parse('${BASE_URL}service'),
        headers: {'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',});
    List tempList = [];
    var data = jsonDecode(response.body);
    if (response.statusCode != 200) {
      throw data["message"];
    }
      // print('data: ${data}');
    for (var v in data.value) {
      // var key = entry.key;
      // var value = entry.value;
      print('Key: $v');
      // if(key == 'data'){
      //   List tempList = value;
      // }
      // tempList.add(v);
    }
    return ServicesModel.serviceFromSnapshot(tempList);
   }
}