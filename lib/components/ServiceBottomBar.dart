// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';

import '../styles/color.dart';

class ServiceBottomBar extends StatefulWidget {
  const ServiceBottomBar({Key? key}) : super(key: key);

  @override
  _ServiceBottomBar createState() => _ServiceBottomBar();
}

class _ServiceBottomBar extends State<ServiceBottomBar> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController kilogramController = TextEditingController();
  final TextEditingController chatLieuVaiController = TextEditingController();
  final TextEditingController loaiDoController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  String selectedMuiHuong = '';
  bool isFastDelivery = false;

  @override
  void dispose() {
    kilogramController.dispose();
    chatLieuVaiController.dispose();
    loaiDoController.dispose();
    diaChiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: wWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "\$120",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          ServiceBottomBar(),
        ],
      ),
    );
  }
}
