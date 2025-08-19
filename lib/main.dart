import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tts_nest/theme.dart';

import 'UI/Dashboard/Component/dashboard_screen.dart';
import 'UI/Login/Controller/login_controller.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: AppTheme.lightTheme,
      initialBinding: BindingsBuilder(() {
        Get.put(LoginController());
      }),
      home: const DashboardScreen(),
    );
  }
}
