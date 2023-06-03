import 'package:flutter/material.dart';

import '../styles/color.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh toán thành công',
          style: TextStyle(
              color: wBlack,
              fontSize: 23,
              fontWeight: FontWeight.bold // Thay đổi màu chữ của tiêu đề
              ),
        ),
        iconTheme: const IconThemeData(
            color: wBlack, size: 30 // Thay đổi màu của biểu tượng nút Back
            ),
        backgroundColor: wPurBlue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/mew1.gif', // Đường dẫn đến hình ảnh minh họa
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 20),
            const Text(
              'Đặt hàng thành công!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Cảm ơn bạn đã đặt dịch vụ tại BIFAT LAUNDRY.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Nhân viên sẽ liên hệ bạn trong vòng 30 phút để xác nhận đơn hàng.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // TODO: Xử lý khi nhấn nút 'Theo dõi đơn hàng'
                //Navigator.pushNamed(context, 'followOrder');
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(wPurBlue),
              ),
              child: const Text(
                'Theo dõi đơn hàng',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}