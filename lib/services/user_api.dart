import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/model_address/district_model.dart';
import 'package:bifat_app/models/model_address/ward_model.dart';
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
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      final data = json['data'] as List<dynamic>;
      final provinces = data.map((e) {
        return ProvinceModel.fromJson(e);
      }).toList();
      return provinces;
    } else {
      throw ('Failed to fetch districts. Error: ${res.statusCode}');
    }
  }

  static Future<List<DistrictModel>> fetchProvinceByCode() async {
    var token = await FirebaseServices.getAccessToken();
    const url = '$BASE_URL/address/provinces/79';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      final data = json['data'] as List<dynamic>;
      final districts = data.map((e) {
        return DistrictModel.fromJson(e);
      }).toList();
      return districts;
    } else {
      throw ('Failed to fetch districts. Error: ${res.statusCode}');
    }
  }

  static Future<List<WardModel>> fetchDistrictsByCode(String code) async {
    var token = await FirebaseServices.getAccessToken();
    var url = '$BASE_URL/address/districts/${code}';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      final data = json['data'] as List<dynamic>;
      final wards = data.map((e) {
        return WardModel.fromJson(e);
      }).toList();
      return wards;
    } else {
      throw ('Failed to fetch districts. Error: ${res.statusCode}');
    }
  }

  static Future<List<DistrictModel>> fetchDistricts() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '$BASE_URL/address/districts';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      final data = json['data'] as List<dynamic>;
      final districts = data.map((e) {
        return DistrictModel.fromJson(e);
      }).toList();
      return districts;
    } else {
      throw ('Failed to fetch districts. Error: ${res.statusCode}');
    }
  }

  static Future<List<WardModel>> fetchWards() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '$BASE_URL/address/wards';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      final body = res.body;
      final json = jsonDecode(body);
      final data = json['data'] as List<dynamic>;
      final wards = data.map((e) {
        return WardModel.fromJson(e);
      }).toList();
      return wards;
    } else {
      throw ('Failed to fetch districts. Error: ${res.statusCode}');
    }
  }
  
  
}
