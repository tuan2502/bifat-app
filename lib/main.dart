import 'package:bifat_app/Onboarding_Screen/onboarding_screen.dart';
import 'package:bifat_app/components/ServiceDetail.dart';
import 'package:bifat_app/pages/CartPage.dart';
import 'package:bifat_app/pages/Combo1.dart';
import 'package:bifat_app/pages/HomePage.dart';
import 'package:bifat_app/pages/LaundryCombo1Page.dart';
import 'package:bifat_app/pages/LaundryCombo2Page.dart';
import 'package:bifat_app/pages/TrackingPage.dart';
import 'package:bifat_app/pages/login_page.dart';
import 'package:bifat_app/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
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
      initialRoute: '/',
      routes: {
        '/': (context) => OnBoardingScreen(),
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
        'profilePage': (context) => const ProfilePage()
      },
    );
  }
}
