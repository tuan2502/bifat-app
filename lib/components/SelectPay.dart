import 'package:flutter/material.dart';

import '../styles/color.dart';

class PaymentOptions extends StatefulWidget {
  const PaymentOptions({super.key});

  @override
  _PaymentOptionsState createState() => _PaymentOptionsState();
}

class _PaymentOptionsState extends State<PaymentOptions> {
  int selectedOption = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RadioListTile<int>(
          value: 0,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
          title: const Text('Thanh toán bằng tiền mặt'),
        ),
        RadioListTile<int>(
          value: 1,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SizedBox(
                    width: 300,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset("assets/images/Banking.png"),
                        const Positioned(
                          bottom: 250,
                          child: Text(
                            'MÃ: 190037282',
                            style: TextStyle(
                              color: wWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          title: const Text('Thanh toán qua VNPay'),
          //contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          // secondary: selectedOption == 2
          //     ? Image.asset('assets/images/bifat (2).png')
          //     : null,
        ),
        RadioListTile<int>(
          value: 2,
          groupValue: selectedOption,
          onChanged: (value) {
            setState(() {
              selectedOption = value!;
            });
          },
          title: const Text('Thanh toán qua ví BIFAT'),
        ),
      ],
    );
  }
}