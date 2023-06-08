import 'package:flutter/material.dart';

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
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       content: SizedBox(
            //         width: 320,
            //         height: 320,
            //         child: Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Image.asset("assets/images/Banking.png"),
            //             const Positioned(
            //               bottom: 260,
            //               child: Text(
            //                 'MÃ: 190037282',
            //                 style: TextStyle(
            //                   color: wWhite,
            //                   fontSize: 20,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //             const Positioned(
            //               top: 300,
            //               //bottom: 5,
            //               child: Text(
            //                 '* Nội dung CK: Ten KH + Ten dich vu ',
            //                 style: TextStyle(
            //                   color: wBlack,
            //                   fontSize: 14,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       actions: [
            //         TextButton(
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //           child: const Text(
            //             'Close',
            //             style: TextStyle(
            //                 fontSize: 20, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
          title: const Text('Thanh toán qua Banking'),
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
