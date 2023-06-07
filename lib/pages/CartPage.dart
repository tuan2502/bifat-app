import 'package:flutter/material.dart';
import '../styles/color.dart';
import '../components/SelectPay.dart';
import '../widgets/OrderWidget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Giỏ hàng',
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
      body: ListView(
        children: [
          // const ServiceAppBar(
          //   namePage: 'Giỏ hàng',
          // ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: wWhite,
            ),
            child: Column(
              children: [
                //const CartItemSamples(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: wWhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF475269).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Tên dịch vụ: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: wBlack,
                            ),
                          ),
                          Text(
                            "Giặt Combo 1",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: wBlack,
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.8,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Số kilogam: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.8,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Tiền dịch vụ:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "179.000",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.8,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Shipping:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "30.000",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.8,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Giặt nhanh:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.8,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Discount:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "-10.000",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Tổng:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "199.000",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const PaymentOptions(),
                const SizedBox(height: 0),
                const OrderScreen(),
                //const ServiceBottomBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
