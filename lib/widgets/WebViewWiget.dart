import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../styles/color.dart';

class PaymentWebView extends StatefulWidget {
  const PaymentWebView({Key? key}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  final String paymentUrl =
      'https://facebook.com'; // Thay thế bằng URL của trang web nạp tiền

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nạp tiền',
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
      body: WebView(
        initialUrl: paymentUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}