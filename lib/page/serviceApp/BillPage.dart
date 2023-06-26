import 'dart:convert';

import 'package:bifat_app/models/fragrant_model.dart';
import 'package:bifat_app/models/item_type_model.dart';
import 'package:bifat_app/models/material_model.dart';
import 'package:bifat_app/models/order_model.dart';
import 'package:bifat_app/page/payment/PaymentPage.dart';
import 'package:bifat_app/page/payment/PaymentSuccess.dart';
import 'package:bifat_app/page/payment/QRcode.dart';

import 'package:bifat_app/services/user_service_api.dart';
import 'package:bifat_app/styles/color.dart';
import 'package:bifat_app/utils/FormatValue.dart';
import 'package:flutter/material.dart';

import '../../models/model_service/service_detail_model.dart';

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) {
    double shipping = 30000;
    double fastService = 30000;

    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    if (args == null) {
      // Xử lý trường hợp không có đối số được truyền vào.
      return const Scaffold(
        body: Center(
          child: Text('No arguments'),
        ),
      );
    }
    ServiceDetailModel serviceDetail = args['serviceDetail'];
    OrderModel orderModel = args['orderModel'];
    List<FragrantModel> fragrantModel = args['fragrantModel'];
    List<ItemTypeModel> itemTypeModel = args['itemTypeModel'];
    List<MaterialModel> materialModel = args['materialModel'];
    int selectedPay = args['payment'];
    print('pay1: ${orderModel.address}');

    double total = orderModel.totalPrice ?? 0.0;
    // print('data: ${serviceDetail.id}');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hóa đơn',
          style: TextStyle(
              color: wWhite,
              fontSize: 23,
              fontWeight: FontWeight.bold // Thay đổi màu chữ của tiêu đề
              ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen
            Navigator.pop(context);
          },
        ),
        backgroundColor: wPurBlue,
      ),
      body: ListView(
        children: [
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
                        children: [
                          const Text(
                            "Tên dịch vụ: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: wBlack,
                            ),
                          ),
                          Text(
                            '${utf8.decode(serviceDetail!.name.toString().runes.toList())}',
                            style: const TextStyle(
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
                        children: [
                          const Text(
                            "Số kilogam: ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "${orderModel.totalQuantity} Kg",
                            style: const TextStyle(
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
                        children: [
                          const Text(
                            "Phí dịch vụ:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "${FormatValue.formatMoney(serviceDetail!.price).toString()}",
                            style: const TextStyle(
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
                        children: [
                          const Text(
                            "Phí giao hàng:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            orderModel.isShipping == 'SHIPPING'
                                ? '${FormatValue.formatMoney(shipping).toString()}'
                                : '0 VNĐ',
                            style: const TextStyle(
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
                        children: [
                          const Expanded(
                            child: Text(
                              'Địa chỉ:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475269),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              orderModel.isShipping == 'SHIPPING'
                                  ? orderModel.address.toString()
                                  : 'Không giao nhận hàng',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF475269),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Divider(
                        height: 30,
                        thickness: 0.8,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Giặt nhanh:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            (DateTime.parse(orderModel.deliveryDate.toString())
                                        .difference(DateTime.parse(
                                            orderModel.receiveDate.toString()))
                                        .inDays <=
                                    1)
                                ? '${FormatValue.formatMoney(fastService).toString()}'
                                : "0 VNĐ",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          )
                        ],
                      ),
                      // const Divider(
                      //   height: 30,
                      //   thickness: 0.8,
                      //   color: Color(0xFF475269),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: const [
                      //     Text(
                      //       "Discount:",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //         color: Color(0xFF475269),
                      //       ),
                      //     ),
                      //     Text(
                      //       "",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //         color: Color(0xFF475269),
                      //       ),
                      //     )
                      //   ],
                      // ),

                      const Divider(
                        height: 30,
                        thickness: 0.5,
                        color: Color(0xFF475269),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            serviceDetail.price == 0
                                ? "Tổng tạm tính:"
                                : "Tổng đơn hàng:",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF475269),
                            ),
                          ),
                          Text(
                            "${FormatValue.formatMoney(orderModel?.totalPrice).toString()}",
                            style: const TextStyle(
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
                const SizedBox(height: 50),
                // const OrderScreen(),
                InkWell(
                  onTap: () => {},
                  child: Container(
                    alignment: Alignment.center,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 110),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Xác nhận đặt hàng'),
                              content: const Text(
                                  'Bạn có chắc chắn muốn đặt hàng không?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Đóng dialog
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Hủy',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const SizedBox(width: 160),
                                TextButton(
                                  onPressed: () async {
                                    var response =
                                        await UserServiceApi.orderService(
                                            orderModel);
                                    if (selectedPay == 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PaymentSuccessPage()));
                                    } else if (selectedPay == 1) {
                                      print(
                                          'total: ${orderModel.totalPrice!.toDouble()}');
                                      String urlVnpay = await UserServiceApi
                                          .postCostFromVNPay(
                                              orderModel.totalPrice!.toDouble(),
                                              response.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PaymentPage(url: urlVnpay)));
                                    } else if (selectedPay == 2) {
                                      await UserServiceApi.postCostFromWallet(
                                          response.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PaymentSuccessPage()));
                                    } else if (selectedPay == 3) {
                                      await UserServiceApi.postCostFromWallet(
                                          response.toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => QRcode(imgPath: 'assets/images/Banking (1).png',)));
                                    }
                                  },
                                  child: const Text(
                                    'Đồng ý',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        "Xác nhận dịch vụ",
                        style: TextStyle(
                          color: wWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
