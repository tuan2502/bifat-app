import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/model_voucher/voucher_detail_model.dart';
import '../../services/voucher_api.dart';
import '../../styles/color.dart';
import '../../utils/FormatValue.dart';

class DiscountDetailPage extends StatefulWidget {
  final String code;
  final double price;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime postDate;
  final String name;
  final int quantity;
  final String imageUrl;

  const DiscountDetailPage({
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

  @override
  _DiscountDetailPageState createState() => _DiscountDetailPageState();
}

class _DiscountDetailPageState extends State<DiscountDetailPage> {
  List<VoucherDetailModel> vouchers = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var voucher in vouchers)
                Text(
                  'Code: ${voucher.code}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'Price: ${FormatValue.formatMoney(voucher.price).toString()}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'Description:${utf8.decode(voucher.description!.runes.toList())}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'Start Date:  ${DateFormat('dd/MM/yyyy').format(DateTime.parse(voucher.startDate!))}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'End Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(voucher.endDate!))}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'Post Date: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(voucher.postDate!))}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'Name: ${utf8.decode(voucher.name!.runes.toList())}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Text(
                  'Quantity: ${voucher.quantity}',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 10),
              for (var voucher in vouchers)
                Image.network(
                  voucher.imageUrl ?? '',
                  width: 200,
                  height: 200,
                ),
            ],
          ),
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
