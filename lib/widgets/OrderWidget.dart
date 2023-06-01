import 'package:flutter/material.dart';

import '../styles/color.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  void submitOrder(BuildContext context) {
    // Lấy dữ liệu từ các trường nhập liệu (tên, số điện thoại, địa chỉ, vv.)
    var addressController;
    var phoneController;
    var fullNameController;
    String fullName = fullNameController.text;
    String phone = phoneController.text;
    String address = addressController.text;

    // Kiểm tra tính hợp lệ của dữ liệu
    if (fullName.isEmpty || phone.isEmpty || address.isEmpty) {
      // Hiển thị thông báo lỗi nếu các trường nhập liệu còn trống
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill in all fields.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return; // Kết thúc hàm submitOrder nếu dữ liệu không hợp lệ
    }

    // Thực hiện gửi dữ liệu lên server, lưu trữ, vv. ở đây
    // ...
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 15, top: 30),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Fill Order Details",
            style: TextStyle(
              fontSize: 22,
              color: Color(0xFF475269),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: wBlack12,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 370,
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Full Name",
                hintStyle: TextStyle(
                  fontSize: 20,
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: wBlack12,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 370,
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Phone",
                hintStyle: TextStyle(
                  fontSize: 20,
                )),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 15, top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: wBlack12,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 370,
          child: TextFormField(
            decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Address",
                hintStyle: TextStyle(
                  fontSize: 20,
                )),
          ),
        ),
        const SizedBox(height: 50),
        InkWell(
          onTap: () => submitOrder(context),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Order Now",
              style: TextStyle(
                color: wWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}
