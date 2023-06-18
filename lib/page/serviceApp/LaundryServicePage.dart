import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:bifat_app/models/service_detail_model.dart';
import 'package:bifat_app/services/service_api.dart';
import 'package:bifat_app/styles/color.dart';
import 'package:bifat_app/utils/FormatValue.dart';
import 'package:bifat_app/widgets/FormNormalService.dart';
import 'package:flutter/material.dart';

class LaundryServicePage extends StatefulWidget {
  const LaundryServicePage({Key? key}) : super(key: key);

  @override
  _LaundryServicePageState createState() => _LaundryServicePageState();
}

class _LaundryServicePageState extends State<LaundryServicePage> {
  ServiceDetailModel? serviceDetail;
  bool isError = false;
  String errorStr = "";
  bool _isTextVisible = true;

  @override
  void initState() {
    super.initState();
    fetchService();
    // Start the animation
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isError
        ? Center(
            child: Text(
              "An error occurred $errorStr",
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
          )
        : serviceDetail == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                appBar: AppBar(
                  title: Text(
                    '${utf8.decode(serviceDetail!.name.toString().runes.toList())}',
                    style: const TextStyle(
                        color: wWhite,
                        fontSize: 23,
                        fontWeight:
                            FontWeight.bold // Thay đổi màu chữ của tiêu đề
                        ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // Hàm xử lý sự kiện khi người dùng bấm nút back
                      // Ví dụ:
                      Navigator.of(context).pop();
                    },
                  ),
                  iconTheme: const IconThemeData(
                      color: wWhite,
                      size: 30 // Thay đổi màu của biểu tượng nút Back
                      ),
                  backgroundColor: wPurBlue,
                ),
                backgroundColor: Colors.white,
                body: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Image.network(
                        serviceDetail!.image_url.toString(),
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
                              Text(
                                '${utf8.decode(serviceDetail!.name.toString().runes.toList())}',
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
                                      'BEST SELLER',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: _isTextVisible
                                            ? Colors.red
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
                              Text(
                                '${FormatValue.formatMoney(serviceDetail!.price).toString()}',
                                style: const TextStyle(
                                  color: wBlue,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: const [
                                  Text(
                                    "4.7",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: wWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: wWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: wWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                          Text(
                            "${utf8.decode(serviceDetail!.description.toString().runes.toList())}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            //gửi dữ liệu dịch từ trang này qua OrderPage
                            Navigator.pushNamed(context, "orderPage", arguments: serviceDetail);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: wPurBlue,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.shopping_cart,
                                color: wWhite,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Đặt hàng ngay',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }

  Future<void> fetchService() async {
    try {
      serviceDetail = await ServiceApi.fetchServiceById1();
    } catch (error) {
      isError = true;
      errorStr = error.toString();
      log("error $error");
    }
    setState(() {});
  }
}
