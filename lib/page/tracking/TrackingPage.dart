import 'package:flutter/material.dart';

import '../../styles/color.dart';
import 'Tracking.dart';

class TrackingStep {
  final String title;
  final String description;

  TrackingStep({required this.title, required this.description});
}

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Theo dõi đơn hàng',
          style: TextStyle(
              color: wWhite,
              fontSize: 23,
              fontWeight: FontWeight.bold // Thay đổi màu chữ của tiêu đề
              ),
        ),
        iconTheme: const IconThemeData(
            color: wWhite, size: 30 // Thay đổi màu của biểu tượng nút Back
            ),
        backgroundColor: wPurBlue,
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isSuccess = true;
              });
            },
            child: Tracking(
              title: "Đã đặt hàng",
              description: isSuccess ? "Thành công" : "Đơn đang được xử lý",
            ),
          ),
          // InkWell(
          //   onTap: () {},
          //   child: const Tracking(
          //     title: "Đang xử lý",
          //     description: "description",
          //   ),
          // ),
          // InkWell(
          //   onTap: () {},
          //   child: const Tracking(
          //     title: "db",
          //     description: "description",
          //   ),
          // ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, 'homePage');
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              wPurBlue), // Màu nền khi không được nhấn // Màu nền khi được nhấn
        ),
        child: const Text(
          'Về trang chủ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
