import 'package:flutter/material.dart';

class Tracking extends StatelessWidget {
  final String title;
  final String description;

  const Tracking({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // final bool isSuccess = description == '?';

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
            height: 20,
          ),
        ],
      ),
    );
  }
}
