import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/color.dart';

class ServiceMore extends StatelessWidget {
  const ServiceMore({
    Key? key,
    required this.imgPath,
    required this.nameService,
    required this.descriptionService,
  }) : super(key: key);

  final String imgPath;
  final String nameService;
  final String descriptionService;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
      margin: const EdgeInsets.only(left: 12, top: 20, right: 12),
      decoration: const BoxDecoration(
        color: wWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 90, // Tùy chỉnh kích thước rộng của hình ảnh
            height: 90, // Tùy chỉnh kích thước cao của hình ảnh
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imgPath),
                fit: BoxFit.cover,
              ),
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: Text(
              '${nameService.capitalize}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
