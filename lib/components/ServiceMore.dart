import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.only(left: 12, top: 15, right: 5),
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
            width: 120, // Tùy chỉnh kích thước rộng của hình ảnh
            height: 120, // Tùy chỉnh kích thước cao của hình ảnh
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imgPath),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: wBlack12,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              nameService,
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
