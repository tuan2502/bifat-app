import 'package:bifat_app/Onboarding_Screen/onboarding_screen.dart';
import 'package:bifat_app/components/ServiceDetail.dart';
import 'package:bifat_app/pages/CartPage.dart';
import 'package:bifat_app/pages/HomePage.dart';
import 'package:bifat_app/pages/LaundryCombo1Page.dart';
import 'package:bifat_app/pages/LaundryServicePage.dart';
import 'package:bifat_app/pages/OrderPage.dart';
import 'package:bifat_app/pages/Page404.dart';
import 'package:bifat_app/pages/TrackingPage.dart';
import 'package:bifat_app/pages/login_page.dart';
import 'package:bifat_app/pages/profile_page.dart';
import 'package:bifat_app/pages/BillPage.dart';
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
        'combo1Page': (context) => const LaundryCombo1Page(),
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
