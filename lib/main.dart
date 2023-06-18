import 'package:bifat_app/components/ServiceDetail.dart';
import 'package:bifat_app/page/cart/CartPage.dart';
import 'package:bifat_app/page/error/Page404.dart';
import 'package:bifat_app/page/home/HomePage.dart';
import 'package:bifat_app/page/login/login_page.dart';
import 'package:bifat_app/page/profile/profile_page.dart';
import 'package:bifat_app/page/serviceApp/BillPage.dart';
import 'package:bifat_app/page/serviceApp/LaundryCombo1Page.dart';
import 'package:bifat_app/page/serviceApp/LaundryServicePage.dart';
import 'package:bifat_app/page/serviceApp/OrderPage.dart';
import 'package:bifat_app/page/tracking/TrackingPage.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginPage',
      routes: {
        // '/': (context) => const OnBoardingScreen(),
        'loginPage': (context) => const LoginPage(),
        'homePage': (context) => const HomePage(),
        'laundryPage': (context) => const LaundryServicePage(),
        'servicePage': (context) => const ServiceDetailPage(
            imgUrl: "assets/images/bifat (2).png",
            serviceName: "serviceName",
            price: 2,
            quantity: 1,
            description: "description"),
        'trackingPage': (context) => const TrackingPage(),
        'cartPage': (context) => const CartPage(),
        'profilePage': (context) => const ProfilePage(),
        'orderPage': (context) => const OrderPage(),
        'billPage': (context) => BillPage(),
        'errorPage': (context) => Page404()
      },
    );
  }
}
