import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Widgets/custom_button.dart';
import '../../../Widgets/custom_fields.dart';
import '../Controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // keep it compact
                children: [
                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Back!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Sign in to access your nest history and get real time updates",
                  ),
                  const SizedBox(height: 32),
                  CircleTextField(
                    hint: 'Email',
                    controller: controller.emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Obx(() => CircleTextField(
                        hint: 'Password',
                        controller: controller.passCtrl,
                        obscureText: controller.obscure.value,
                        suffix: IconButton(
                          onPressed: controller.toggleObscure,
                          icon: Icon(controller.obscure.value
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded),
                        ),
                      )),
                  const SizedBox(height: 24),
                  Obx(() => CustomButton(
                        text: 'Login',
                        onPressed: controller.login,
                        isLoading: controller.isLoading.value,
                      )),
                  const SizedBox(height: 20),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: "Register",
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.goToRegister,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
