import 'package:bifat_app/page/profile/widget/body_profile.dart';
import 'package:bifat_app/styles/color.dart';
import 'package:flutter/material.dart';

class ProfileDemo extends StatefulWidget {
  const ProfileDemo({super.key});

  @override
  State<ProfileDemo> createState() => _ProfileDemoState();
}

class _ProfileDemoState extends State<ProfileDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: wPurBlue,
      ),
      body: const Body(),
    );
  }
}
