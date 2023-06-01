import 'package:flutter/material.dart';

import '../styles/color.dart';

class TrackingStep {
  final String title;
  final String description;

  TrackingStep({required this.title, required this.description});
}

class TrackingPage extends StatelessWidget {
  final List<TrackingStep> trackingSteps = [
    TrackingStep(
      title: 'Đã đặt hàng',
      description: 'Đơn hàng của bạn đã được đặt thành công.',
    ),
    TrackingStep(
      title: 'Đang vận chuyển',
      description:
          'Đơn hàng của bạn đang được vận chuyển đến địa chỉ giao hàng.',
    ),
    TrackingStep(
      title: 'Đã giao hàng',
      description: 'Đơn hàng của bạn đã được giao thành công.',
    ),
  ];

  TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theo dõi đơn hàng'),
        backgroundColor: wPurBlue,
      ),
      body: ListView.builder(
        itemCount: trackingSteps.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trackingSteps[index].title,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trackingSteps[index].description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                  if (index != trackingSteps.length - 1) ...[
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 1,
                      color: wBlack,
                      height: 24,
                    ),
                  ],
                ],
              ),
            ),
          );
        },
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