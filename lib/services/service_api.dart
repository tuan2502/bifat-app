import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/models/fragrant_model.dart';
import 'package:bifat_app/models/item_type_model.dart';
import 'package:bifat_app/models/material_model.dart';
import 'package:bifat_app/models/service_detail_model.dart';
import 'package:bifat_app/models/services_model.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;

class ServiceApi {
  /*s
  * API lấy toàn bộ services
  */
  static Future<List<ServicesModel>> fetchServices() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '$BASE_URL/service';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    final services = data.map((e) {
      return ServicesModel.fromJson(e);
    }).toList();
    return services;
  }

  static Future<List<ServiceDetailModel>> fetchServiceById() async {
    var token = await FirebaseServices.getAccessToken();
    var serviceId = await FirebaseServices.getServiceId();
    List tempList = [];
    var url = '$BASE_URL/service/serviceId/$serviceId';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers:{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'];
    tempList.add(data);
    print('data: $data');
    final service = tempList.map((e) {
      return ServiceDetailModel.fromJson(e);
    }).toList();
    return service;
  }

  static Future<ServiceDetailModel> fetchServiceById1() async {
    var token = await FirebaseServices.getAccessToken();
    var serviceId = await FirebaseServices.getServiceId();
    // List tempList = [];
    var url = '$BASE_URL/service/serviceId/$serviceId';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers:{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'];

    if (res.statusCode != 200) {
      throw data["message"];
    }
    return ServiceDetailModel.fromJson(data);
  }

   static Future<List<FragrantModel>> fetchFragrants() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '$BASE_URL/fragrants?page=1&size=10';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    final fragrants = data.map((e) {
      return FragrantModel.fromJson(e);
    }).toList();
    return fragrants;
  }

  //get itemTye data  
  static Future<List<ItemTypeModel>> fetchItemTypes() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '$BASE_URL/itemType?page=1&size=10';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    // print('itemType: $data');
    final itemTypes = data.map((e) {
      return ItemTypeModel.fromJson(e);
    }).toList();
    return itemTypes;
  }

  //get material data
  static Future<List<MaterialModel>> fetchMaterials() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '$BASE_URL/material?page=1&size=10';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    final data = json['data'] as List<dynamic>;
    // print('material: $data');
    final materials = data.map((e) {
      return MaterialModel.fromJson(e);
    }).toList();
    return materials;
  }
  
}
