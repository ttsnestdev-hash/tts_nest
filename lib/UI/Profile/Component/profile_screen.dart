import 'package:flutter/material.dart';

import '../../../Widgets/Appbar/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
          title: "Profile",
          showBack: true,
      ),
      body: Center(
        child: Text("Profile Screen"),
      ),
    );
  }
}
