import 'package:flutter/material.dart';

import '../../styles/color.dart';

class Tips extends StatelessWidget {
  const Tips({
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
      // padding: const EdgeInsets.only(left: 5, right: 2, top: 1),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: const BoxDecoration(
        // color: wPurBlue,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      constraints: const BoxConstraints(
        maxHeight: 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 190, // Tùy chỉnh kích thước rộng của hình ảnh
            height: 150, // Tùy chỉnh kích thước cao của hình ảnh
            //alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imgPath),
                fit: BoxFit.cover,
              ),
              boxShadow: const [
                BoxShadow(
                  color: wWhite,
                  blurRadius: 30,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 10),
            child: Text(
              nameService,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(top: 5, left: 10),
          //   child: Text(
          //     descriptionService,
          //     style: const TextStyle(
          //       fontSize: 16,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
        ],
      ),
      // child: Column(
      //   children: [
      //     Container(
      //       margin: const EdgeInsets.all(10),
      //       child: Image.asset(
      //         imgPath,
      //         height: 120,
      //         width: 150,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(bottom: 8),
      //       child: Container(
      //         alignment: Alignment.centerLeft,
      //         child: Text(
      //           nameService,
      //           style: const TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.black45,
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //       alignment: Alignment.centerLeft,
      //       child: Text(
      //         descriptionService,
      //         style: const TextStyle(
      //           fontSize: 16,
      //           color: Colors.black54,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
