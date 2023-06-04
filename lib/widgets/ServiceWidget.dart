import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import '../components/ServiceMore.dart';
import 'package:http/http.dart' as http;


class ServiceWidget extends StatefulWidget {
  
  const ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {

  List<dynamic> services = [];

  Future<void> fetchService() async {
    var token = await FirebaseServices.getAccessToken();
    // print('token: $token');
    const url = '${BASE_URL}/service';
    final uri = Uri.parse(url);
    final res = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final body = res.body;
    final json = jsonDecode(body);
    setState(() {
      services = json['data'];
    });
    print('services: $services');
  }

   void initState() {
    fetchService();
    // ApiHandler.getAllData();
    super.initState();
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
                Navigator.pushNamed(context, 'laundryPage');
              },
              child: ServiceMore(
                imgPath: service['image_url'].toString(),
                nameService: service['name'].toString(),
                descriptionService:
                    'Giặt theo kí - sự lựa chọn của mọi nhà',

              ),
            ),
          // InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, 'combo1Page');
          //   },
          //   child: const ServiceMore(
          //     imgPath: 'assets/images/bifat (5).png',
          //     nameService: 'Giặt ủi Combo 1',
          //     descriptionService: 'Sự lựa chọn tiết kiệm cho gia đình',
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, 'combo2Page');
          //   },
          //   child: const ServiceMore(
          //     imgPath: 'assets/images/bifat (2).png',
          //     nameService: 'Giặt ủi Combo 2',
          //     descriptionService: 'Combo siêu ưu đãi tới mọi gia đình',
          //   ),
          // ),
          // InkWell(
          //   onTap: () {
          //     Navigator.pushNamed(context, 'servicePage');
          //   },
          //   child: const ServiceMore(
          //     imgPath: 'assets/images/coming.jpg',
          //     nameService: 'Coming Soon',
          //     descriptionService: 'Coming Soon',
          //   ),
          // ),
          
          // Add more InkWell widgets for additional items
        ],
      ),
    );
  }

}
