import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/model_voucher/voucher_detail_model.dart';
import '../../services/voucher_api.dart';
import '../../styles/color.dart';

class DiscountPageDetail extends StatefulWidget {
  const DiscountPageDetail({
    Key? key,
    required this.code,
    required this.price,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.postDate,
    required this.name,
    required this.quantity,
    required this.imageUrl,
  }) : super(key: key);

  final String code;
  final double price;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime postDate;
  final String name;
  final int quantity;
  final String imageUrl;

  @override
  _DiscountPageDetailState createState() => _DiscountPageDetailState();
}

class _DiscountPageDetailState extends State<DiscountPageDetail> {
  List<VoucherDetailModel> vouchers = [];

  @override
  void initState() {
    super.initState();
    fetchVouchers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thông tin Discount',
          style: TextStyle(
            color: wWhite,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: wWhite,
          size: 30,
        ),
        backgroundColor: wPurBlue,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.zero,
        child: ListView(
          shrinkWrap: true,
          children: [
            for (var voucher in vouchers)
              Padding(
                padding: const EdgeInsets.all(0),
                child: Image.network(
                  voucher.imageUrl.toString(),
                  height: 220,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var voucher in vouchers)
                    Text(
                      utf8.decode(voucher.name!.runes.toList()),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  const SizedBox(height: 15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     for (var voucher in vouchers)
                  //       Text(
                  //         FormatValue.formatMoney(voucher.price).toString(),
                  //         style: const TextStyle(
                  //           color: wBlue,
                  //           fontSize: 25,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: wWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Ngày tạo",
                              style: TextStyle(
                                color: wBlue,
                                fontSize: 18,
                              ),
                            ),
                            for (var voucher in vouchers)
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(voucher.postDate!)),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: wWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Bắt đầu",
                              style: TextStyle(
                                color: wBlue,
                                fontSize: 18,
                              ),
                            ),
                            for (var voucher in vouchers)
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(voucher.startDate!)),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: wWhite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "Kết thúc",
                              style: TextStyle(
                                color: wBlue,
                                fontSize: 18,
                              ),
                            ),
                            for (var voucher in vouchers)
                              Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(DateTime.parse(voucher.endDate!)),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  for (var voucher in vouchers)
                    Text(
                      utf8.decode(voucher.description!.runes.toList()),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  //...
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: wPurBlue,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Lấy Voucher',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchVouchers() async {
    final response = await VoucherApi.fetchVoucherById();
    setState(() {
      vouchers = response;
      print('voucher: $vouchers');
    });
  }
}
