import 'dart:async';

import 'package:bifat_app/components/Checkbox.dart';
import 'package:bifat_app/models/service_detail_model.dart';
import 'package:bifat_app/services/service_api.dart';
import 'package:bifat_app/widgets/FormatValue.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../styles/color.dart';
import 'CartPage.dart';

class LaundryCombo1Page extends StatefulWidget {
  const LaundryCombo1Page({Key? key}) : super(key: key);

  @override
  _LaundryCombo1PageState createState() => _LaundryCombo1PageState();
}

class _LaundryCombo1PageState extends State<LaundryCombo1Page> {
  List<ServiceDetailModel> service = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController kilogramController = TextEditingController();
  final TextEditingController chatLieuVaiController = TextEditingController();
  final TextEditingController loaiDoController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  String selectedMuiHuong = '';
  bool isFastDelivery = false;
  bool _isTextVisible = true;
  bool isShippingSelected = false;
  String address = '';
  String selectShip = '';

  @override
  void initState() {
    super.initState();
    fetchServices();
    startAnimation();
  }

  void startAnimation() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _isTextVisible = !_isTextVisible;
      });
    });
  }

  @override
  void dispose() {
    kilogramController.dispose();
    chatLieuVaiController.dispose();
    loaiDoController.dispose();
    diaChiController.dispose();
    super.dispose();
  }

  void toggleShipping(bool? value) {
    setState(() {
      isShippingSelected = value ?? false;
    });
  }

  void showShippingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Shipping'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Shipping'),
                items: <String>['1 Chiều', '2 Chiều'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectShip = newValue ?? '';
                  });
                },
              ),
              const SizedBox(height: 8),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                onChanged: (value) {
                  address = value;
                  // Handle address input
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Đồng ý',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
              onPressed: () {
                // Handle shipping information submission
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      // for (var s in service)
        title: const Text(
          'Giặt Combo 1',
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
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: [
          for (var service in service)
          Padding(
            padding: const EdgeInsets.all(0),
            child: Image.network(
              service.image_url.toString(),
              height: 270,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (var service in service)
                    Text(
                      '${service.name}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.red,
                          size: 25,
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                          child: Text(
                            'BEST CHOICE',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _isTextVisible
                                  ? wPurBlue
                                  : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  for (var service in service)
                     Text(
                      '${FormatValue.formatMoney(service.price).toString()}',
                      style: const TextStyle(
                        color: wBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          "4.5",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          Icons.star,
                          color: wBlue,
                          size: 20,
                        )
                      ],
                    ),
                  ],
                ),
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
                        children: const [
                          Text(
                            "24/7",
                            style: TextStyle(
                              color: wBlue,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Nhận dịch vụ",
                            style: TextStyle(
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
                        children: const [
                          Text(
                            "60p",
                            style: TextStyle(
                              color: wBlue,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Xử lý dịch vụ",
                            style: TextStyle(
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
                        children: const [
                          Text(
                            "60s",
                            style: TextStyle(
                              color: wBlue,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Thông báo",
                            style: TextStyle(
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
                const Text(
                  "Dịch vụ giặt ủi mang tới cho bạn một trải nghiệm tuyệt với và giúp bạn tràn đầy năng lượng sau 1 ngày đi làm mệt mỏi nhưng vẫn thơm tho",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              //color: const Color.fromARGB(82, 209, 168, 91),
              color: wPurBlue,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // TextFormField(
                    //   controller: kilogramController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Số kilogram',
                    //     labelStyle: TextStyle(color: wBlack),
                    //     filled: true,
                    //   ),
                    //   cursorColor: wBlack,
                    // ),
                    // TextFormField(
                    //   controller: chatLieuVaiController,
                    //   decoration: const InputDecoration(
                    //     labelText: 'Chất liệu vải',
                    //     labelStyle: TextStyle(color: wBlack),
                    //     filled: true,
                    //   ),
                    //   cursorColor: wBlack,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Vui lòng nhập chất liệu vải';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    TextFormField(
                      controller: loaiDoController,
                      decoration: const InputDecoration(
                        labelText: 'Loại đồ',
                        labelStyle: TextStyle(color: wBlack),
                        filled: true,
                      ),
                      cursorColor: wBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập loại đồ';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedMuiHuong = 'Downy',
                      decoration: const InputDecoration(
                        labelText: ' Mùi hương',
                        labelStyle: TextStyle(color: wBlack),
                        filled: true,
                      ),
                      items: <String>['Downy', 'Comfort', 'Omo']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMuiHuong = newValue ?? '';
                        });
                      },
                    ),
                    TextFormField(
                      controller: diaChiController,
                      decoration: const InputDecoration(
                        labelText: 'Địa chỉ',
                        labelStyle: TextStyle(color: wBlack),
                        filled: true,
                      ),
                      cursorColor: wBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập địa chỉ';
                        }
                        return null;
                      },
                    ),
                    Wrap(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isShippingSelected,
                              onChanged: toggleShipping,
                            ),
                            const Text(
                              'Shipping',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        if (isShippingSelected)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 1, left: 15),
                                width: 500,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shipping: $selectShip",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Address: $address',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 10,
                                    ),
                                    ElevatedButton(
                                      onPressed: showShippingDialog,
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: wWhite),
                                      child: const Text(
                                        'Edit Shipping',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Row(
                      children: const [
                        CheckBoxFast(name: "Giặt nhanh(+30k)"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
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
              children: [
                for (var service in service)
                  Text(
                    '${FormatValue.formatMoney(service.price).toString()}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Xử lý submit dữ liệu khi các trường hợp lệ
                      String kilogram = kilogramController.text;
                      String chatLieuVai = chatLieuVaiController.text;
                      String loaiDo = loaiDoController.text;
                      String muiHuong = selectedMuiHuong;
                      String diaChi = diaChiController.text;
                      bool isFastDelivery = this.isFastDelivery;

                      // Xử lý dữ liệu theo logic của ứng dụng của bạn
                      // Ví dụ:
                      // - Gửi dữ liệu đến máy chủ
                      // - Lưu vào cơ sở dữ liệu
                      // - Thực hiện tính toán, xử lý logic phức tạp, v.v.

                      // Sau khi hoàn thành xử lý dữ liệu, bạn có thể hiển thị thông báo thành công
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Thông báo!!'),
                            content:
                                const Text('Đã nhận dịch vụ thành công.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Đóng hộp thoại thông báo
                                  Navigator.pushReplacement(
                                    // Điều hướng trở về trang chủ
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const CartPage()),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Thay đổi màu nền của nút
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check, // Icon kiểu check
                        color: Colors.white, // Thay đổi màu của icon
                      ),
                      SizedBox(width: 8), // Khoảng cách giữa icon và text
                      Text(
                        'Đặt thôi', // Nội dung text
                        style: TextStyle(
                            color: Colors.white), // Thay đổi màu của text
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchServices() async {
    final response = await ServiceApi.fetchServiceById();
    setState(() {
      service = response;
      print('service: $service');
    });
  }
}