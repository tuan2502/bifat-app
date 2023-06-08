import 'package:bifat_app/pages/PaymentSuccess.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import '../styles/color.dart';

class QRcode extends StatefulWidget {
  final String imgPath;

  const QRcode({Key? key, required this.imgPath}) : super(key: key);

  @override
  _QRcodeState createState() => _QRcodeState();
}

class _QRcodeState extends State<QRcode> {
  File? _file;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thanh toán',
          style: TextStyle(
            color: wBlack,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: wBlack,
          size: 30,
        ),
        backgroundColor: wPurBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
              ),
              child: Image.asset(
                widget.imgPath,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 2,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Nội dung CK: Ten KH + ten dich vu',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            const Text(
              '(VD: Pham Tuan Combo1)',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(wPurBlue),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(150, 50)), // Set the minimum button size
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(16)), // Set the button padding
              ),
              child: const Text(
                'Chọn tệp',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            if (_file != null) ...[
              const SizedBox(height: 20),
              Text(
                'File được chọn: ${_file!.path.split('/').last}',
                style: const TextStyle(fontSize: 16),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccessPage(),
                  ),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(wPurBlue),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(150, 50)), // Set the minimum button size
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(16)), // Set the button padding
              ),
              child: const Text(
                'Xác nhận',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
