import 'package:flutter/material.dart';

import '../styles/color.dart';

class ServiceAppBar extends StatelessWidget {
  const ServiceAppBar({super.key, required this.namePage});
  final String namePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: wPurBlue,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 30,
              color: wBlack,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              namePage,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: wBlack,
              ),
            ),
          ),
          const Spacer(),
          //
        ],
      ),
    );
  }
}
