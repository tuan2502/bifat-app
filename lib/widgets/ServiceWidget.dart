import 'dart:convert';

import 'package:bifat_app/models/services_model.dart';
import 'package:bifat_app/services/service_api.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/ServiceMore.dart';


class ServiceWidget extends StatefulWidget {
  
  const ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  List<ServicesModel> services = [];

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  void initState() {
    super.initState();
    fetchServices();
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
    final SharedPreferences? prefs = await _prefs;
    await prefs?.setString('serviceId', serviceId);
    return true;
  }

}
