import 'package:bifat_app/page/login/login_page.dart';
import 'package:bifat_app/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
            const SizedBox(
              height: 20,
            ),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Logout"),
              onPressed: () async {
                await FirebaseServices().signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
