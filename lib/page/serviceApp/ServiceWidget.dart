import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:bifat_app/services/service_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/ServiceMore.dart';
import '../../const/api_const.dart';
import '../../models/model_service/services_model.dart';
import '../../services/firebase_services.dart';

class ServiceWidget extends StatefulWidget {
  const ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  List<ServicesModel> services = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    fetchServices();
    placeOrder();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var service in services)
            InkWell(
              onTap: () {
                saveServiceIdToLocalStorage(serviceId: service.id.toString());
                Navigator.pushNamed(context, 'laundryPage');
              },
              child: ServiceMore(
                imgPath: service.image_url.toString(),
                nameService: service.name.toString(),
                descriptionService:
                    'Giặt theo kí - sự lựa chọn của mọi nhà',
              ),
            ),
        ],
      ),
    );
  }

  Future<void> fetchServices() async {
    final response = await ServiceApi.fetchServices();
    setState(() {
      services = response;
    });
  }

  saveServiceIdToLocalStorage({required String serviceId}) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('serviceId', serviceId);
    return true;
  }

  Future<void> placeOrder() async {
    var token = await FirebaseServices.getAccessToken();
    var serviceId = await FirebaseServices.getServiceId();
    // print('token: $token');
    final url =
        '$BASE_URL/user-service/check-user-service?serviceId=$serviceId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final body = response.body;
        final jsonData = jsonDecode(body);
        print(jsonData);
        // Process the JSON data and handle the order placement logic
      } else {
        // Handle error responses
        print('Failed to place order. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or API-related errors
      print('Failed to place order. Error: $error');
    }
  }
}
