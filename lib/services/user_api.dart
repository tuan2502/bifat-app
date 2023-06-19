import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/user_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/model_address/province_model.dart';
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

  // static Future<List<UpdateProfile>> fetchUpdate() async {
  //   var token = await FirebaseServices.getAccessToken();
  //   List tempList = [];
  //   const url = '$BASE_URL/users/profile';
  //   final uri = Uri.parse(url);
  //   final res = await http.get(uri, headers: {
  //     'Content-Type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });
  //   final body = res.body;
  //   final json = jsonDecode(body);
  //   final data = json['data'];
  //   tempList.add(data);
  //   // print('tempList: $tempList');
  //   final user = tempList.map((e) {
  //     return UpdateProfile.fromJson(e);
  //   }).toList();
  //   return user;
  // }

  static Future<void> updateUserProfile(
    String fullname,
    String birthday,
    String addressNum,
    String district,
    String province,
    String ward,
  ) async {
    var token = await FirebaseServices.getAccessToken();
    const url = '$BASE_URL/users/profile';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        "fullname": fullname,
        "birthday": birthday,
        "addressnum": addressNum,
        "district": district,
        "province": province,
        "ward": ward,
      }),
    );
    try {
      if (response.statusCode == 200) {
        print("data put: ${response.body}");
        print('Profile updated successfully');
      } else {
        print('Failed to update profile. Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred while updating profile: $error');
    }
  }

  static Future<List<ProvinceModel>> fetchProvinces() async {
    var token = await FirebaseServices.getAccessToken();
    const url = '$BASE_URL/address/provinces';
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      final responseBody = response.body;
      final provincesData = json.decode(responseBody);
      if (provincesData != null && provincesData['provinces'] != null) {
        final List<ProvinceModel> provinces = [];
        for (var provinceData in provincesData['provinces']) {
          final province = ProvinceModel.fromJson(provinceData);
          provinces.add(province);
        }
        return provinces;
      }
    }

    throw Exception('Failed to fetch provinces. Error: ${response.statusCode}');
  }

  static Future<void> fetchDistricts() async {
    const url = '$BASE_URL/address/districts';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final provincesData = json.decode(response.body);
      // Process the data here
    } else {
      print('Failed to fetch districts. Error: ${response.statusCode}');
    }
  }

  static Future<void> fetchWards() async {
    const url = '$BASE_URL/address/wards';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final provincesData = json.decode(response.body);
      // Process the data here
    } else {
      print('Failed to fetch wards. Error: ${response.statusCode}');
    }
  }
  // static getWallet() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var wallet = prefs.getString('wallet');
  //   print('wallet: $wallet');
  //   return wallet;
  // }
}
