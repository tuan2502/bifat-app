import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/color.dart';
import '../widgets/DiscountWidget.dart';
import '../widgets/HomeBottomBar.dart';
import '../widgets/ServiceWidget.dart';
import '../widgets/TipsWidget.dart';
import '../widgets/WebViewWiget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                              const CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/Janet.png'),
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
                          const Text(
                            "Nguyễn Thiện Thức",
                            style: TextStyle(
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
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Số tiền bạn muốn nạp'),
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
                                                    offset:
                                                        formattedValue.length,
                                                  ),
                                                );
                                              }),
                                            ],
                                            decoration: const InputDecoration(
                                              labelText: "Số tiền:",
                                              labelStyle: TextStyle(
                                                  color: wBlack, fontSize: 15),
                                              suffixText:
                                                  "VNĐ", // Add the "VNĐ" text as suffix
                                              suffixStyle: TextStyle(
                                                  color: wBlack, fontSize: 15),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const PaymentWebView()),
                                                );
                                              },
                                              child: const Text('OK'),
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
                    const ServiceScreen(),
                    // Center(
                    //   child: SizedBox(
                    //     height: 150,
                    //     child: ListView.builder(
                    //       shrinkWrap: true,
                    //       scrollDirection: Axis.horizontal,
                    //       itemCount: catNames.length,
                    //       itemBuilder: (context, index) {
                    //         return Column(
                    //           children: [
                    //             Container(
                    //               margin: const EdgeInsets.symmetric(
                    //                   vertical: 1, horizontal: 15),
                    //               child: SizedBox(
                    //                 width: 100, // Adjust the width as desired
                    //                 child: InkWell(
                    //                   onTap: () {
                    //                     // Add your onTap logic here
                    //                   },
                    //                   child: SizedBox(
                    //                     // decoration: BoxDecoration(
                    //                     //   color: const Color(0xFFF2F8FF),
                    //                     //   borderRadius:
                    //                     //       BorderRadius.circular(50),
                    //                     //   boxShadow: const [
                    //                     //     BoxShadow(
                    //                     //       color: wBlack,
                    //                     //       blurRadius: 4,
                    //                     //       spreadRadius: 1,
                    //                     //     ),
                    //                     //   ],
                    //                     // ),
                    //                     width: 100,
                    //                     height: 100,
                    //                     child: ClipRect(
                    //                       child: catImg[index],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //             const SizedBox(height: 10),
                    //             Center(
                    //               //padding: const EdgeInsets.only(left: 15),
                    //               child: Text(
                    //                 catNames[index],
                    //                 style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: wBlack.withOpacity(0.7),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // ),
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
      bottomNavigationBar: const HomeBottomBar(),
    );
  }
}
