import 'package:bifat_app/page/profile/widget/edit_profile.dart';
import 'package:flutter/material.dart';

import '../../../services/firebase_services.dart';
import '../../login/login_page.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(
            height: 0,
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: const Icon(Icons.person),
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditProfile()));
            },
          ),
          ProfileMenu(
            text: "Notifications",
            icon: const Icon(Icons.notifications),
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: const Icon(Icons.settings),
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: const Icon(Icons.help_center),
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: const Icon(Icons.logout),
            press: () async {
              await FirebaseServices().signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
