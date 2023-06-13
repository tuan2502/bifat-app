import 'package:bifat_app/page/Cart/CartPage.dart';
import 'package:bifat_app/Tester_Page/Combo1.dart';
import 'package:bifat_app/page/home/HomePage.dart';
import 'package:bifat_app/page/error/Page404.dart';
import 'package:bifat_app/page/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'page/profile/profile_page.dart';
import 'page/profile/proflie_demo.dart';
import 'page/serviceApp/LaundryCombo1Page.dart';
import 'page/serviceApp/LaundryCombo2Page.dart';
import 'page/tracking/TrackingPage.dart';
import 'components/ServiceDetail.dart';
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
      debugShowCheckedModeBanner: false,
      initialRoute: 'loginPage',
      routes: {
        // '/': (context) => const OnBoardingScreen(),
        'loginPage': (context) => const LoginPage(),
        'homePage': (context) => const HomePage(),
        'combo1Page': (context) => const LaundryCombo1Page(),
        'combo2Page': (context) => const LaundryCombo2Page(),
        'laundryPage': (context) => const LaundryCombo1Page(),
        'combo1': (context) => const Combo1(),
        'servicePage': (context) => const ServiceDetailPage(
            imgUrl: "assets/images/bifat (2).png",
            serviceName: "serviceName",
            price: 2,
            quantity: 1,
            description: "description"),
        'trackingPage': (context) => const TrackingPage(),
        'cartPage': (context) => const CartPage(),
        'profilePage': (context) => const ProfilePage(),
        'demoProfile': (context) => const ProfileDemo(),
        'errorPage': (context) => const Page404()
      },
    );
  }
}
