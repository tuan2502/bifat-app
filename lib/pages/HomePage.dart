import 'package:bifat_app/services/api_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/color.dart';
import '../widgets/DiscountWidget.dart';
import '../widgets/HomeBottomBar.dart';
import '../widgets/ServiceWidget.dart';
import '../widgets/TipsWidget.dart';
import '../widgets/WebViewWiget.dart';

// String stringResponse;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiNotification apiNotification = ApiNotification();

  @override
  void initState() {
    super.initState();
    apiNotification.initializeNotifications();
  }

  Future<void> fetchNotificationData() async {
    await apiNotification.showNotification("Hủy", "Thành công");
  }

  void fetchNotificationData1() async {
    await apiNotification.showNotification("Nhập đi", "Đỉ");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        //color: const Color.fromARGB(195, 160, 136, 125),
        color: wWhite,
        child: SingleChildScrollView(
          //scrollDirection: Axis.vertical,
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      wBlue.withOpacity(0.8),
                      wPurBlue,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/poster1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(FirebaseAuth
                                    .instance.currentUser!.photoURL!),
                              ),
                              IconButton(
                                icon: const Icon(Icons.notifications),
                                color: wWhite,
                                iconSize: 25,
                                onPressed: () {
                                  // ....
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Xin chào!",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "${FirebaseAuth.instance.currentUser!.displayName}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 20),
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              //color: const Color.fromARGB(242, 209, 168, 91),
                              color: const Color.fromRGBO(96, 93, 236, 1),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: wBlack,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    SizedBox(width: 18),
                                    Icon(Icons.wallet_membership_outlined),
                                    SizedBox(width: 10),
                                    Text(
                                      'NẠP TIỀN',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 15),
                                    Icon(Icons.compare_arrows_rounded),
                                  ],
                                ),
                                const Text(
                                  "5.000.000 VNĐ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_card_rounded),
                                  color: wBlack,
                                  iconSize: 24,
                                  onPressed: () {
                                    //Navigator.pushNamed(context, "cartPage");
                                    String inputValue = '';

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Số tiền bạn muốn nạp'),
                                          content: TextField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              TextInputFormatter.withFunction(
                                                  (oldValue, newValue) {
                                                final intStringLength =
                                                    newValue.text.length;
                                                final formattedValue =
                                                    StringBuffer();

                                                for (int i = 0;
                                                    i < intStringLength;
                                                    i++) {
                                                  if (i > 0 &&
                                                      (intStringLength - i) %
                                                              3 ==
                                                          0) {
                                                    formattedValue.write('.');
                                                  }
                                                  formattedValue
                                                      .write(newValue.text[i]);
                                                }

                                                return TextEditingValue(
                                                  text:
                                                      formattedValue.toString(),
                                                  selection:
                                                      TextSelection.collapsed(
                                                          offset: formattedValue
                                                              .length),
                                                );
                                              }),
                                            ],
                                            decoration: const InputDecoration(
                                              labelText: 'Số tiền:',
                                              labelStyle: TextStyle(
                                                  color: wBlack, fontSize: 15),
                                              suffixText: 'VNĐ',
                                              suffixStyle: TextStyle(
                                                  color: wBlack, fontSize: 15),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                inputValue = value;
                                              });
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                fetchNotificationData();
                                              },
                                              child: const Text(
                                                'Hủy',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(width: 120),
                                            TextButton(
                                              onPressed: () {
                                                if (inputValue.isEmpty) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Yêu cầu nhập tiền'),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              fetchNotificationData1();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                              'OK',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PaymentWebView()),
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                'OK',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(width: 1),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Đặt dịch vụ',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: wBlack,
                        ),
                      ),
                    ),
                    const ServiceWidget(),
                    const SizedBox(height: 10),
                    const Divider(
                      color: wBlack,
                      thickness: 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Mẹo vặt',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: wBlack.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const TipWidget(),
                    const Divider(
                      color: wBlack,
                      thickness: 0.8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        'Khuyến Mãi',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: wBlack.withOpacity(0.7),
                        ),
                      ),
                    ),
                    const DiscoutWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: fetchService),
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
