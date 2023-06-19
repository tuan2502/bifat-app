import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:http/http.dart' as http;

import '../models/model_service/service_detail_model.dart';
import '../models/model_service/services_model.dart';

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
    // print('data: $data');

    final services = data.map((e) {
      return ServicesModel.fromJson(e);
    }).toList();
    // print('services: $services');

    return services;
  }

  static Future<List<ServiceDetailModel>> fetchServiceById() async {
    var token = await FirebaseServices.getAccessToken();
    var serviceId = await FirebaseServices.getServiceId();
    List tempList = [];
    var url = '$BASE_URL/service/serviceId/$serviceId';
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
    final service = tempList.map((e) {
      return ServiceDetailModel.fromJson(e);
    }).toList();
    return service;
  }
}
