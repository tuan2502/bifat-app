import 'package:flutter/material.dart';
import '../styles/color.dart';
import '../pages/PaymentSuccess.dart';

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
            title: const Text('Lỗi!!'),
            content: const Text('Hãy nhập đầy đủ nhé bạn.'),
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
            "Thông tin giao hàng",
            style: TextStyle(
                fontSize: 22, color: wBlack, fontWeight: FontWeight.w500),
          ),
        ),
        // Container(
        //   margin: const EdgeInsets.only(left: 15, top: 20),
        //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        //   decoration: BoxDecoration(
        //     color: wBlack12,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   width: 370,
        //   child: TextFormField(
        //     decoration: const InputDecoration(
        //         border: InputBorder.none,
        //         hintText: "Full Name",
        //         hintStyle: TextStyle(
        //           fontSize: 20,
        //         )),
        //   ),
        // ),
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
              hintText: "Số điện thoại",
              hintStyle: TextStyle(
                fontSize: 20,
              ),
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
              hintText: "Địa chỉ",
              hintStyle: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        InkWell(
          onTap: () => submitOrder(context),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                      content:
                          const Text('Bạn có chắc chắn muốn đặt hàng không?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Đóng dialog
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Hủy',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 160),
                        TextButton(
                          onPressed: () {
                            // Hủy đặt hàng
                            // Thực hiện đặt hàng ở đây
                            //submitOrder(context);
                            //Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PaymentSuccessPage()),
                            );
                          },
                          child: const Text(
                            'Đồng ý',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
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
                  fontSize: 18,
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
    );
  }
}
