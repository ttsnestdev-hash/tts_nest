import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Routes/Routes.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  final obscure = true.obs;
  final isLoading = false.obs;

  void toggleObscure() => obscure.toggle();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 800)); // mock API
    isLoading.value = false;


    Get.toNamed(Routes.dashboardScreen);
  }

  void goToRegister() {
    // TODO: navigate to your register page
    Get.snackbar('Register', 'Navigate to Register screen',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void onClose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.onClose();
  }
}
