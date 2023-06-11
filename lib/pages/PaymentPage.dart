import 'package:bifat_app/pages/HomePage.dart';
import 'package:bifat_app/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


 class PaymentPage extends StatelessWidget {
  final String url;
  
   PaymentPage ({required this.url});
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BIFAT Pay'),
        backgroundColor: wPurBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
