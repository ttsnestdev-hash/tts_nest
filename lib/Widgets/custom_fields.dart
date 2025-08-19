import 'package:flutter/material.dart';

import '../theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CircleTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const CircleTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.obscureText = false,
    this.suffix,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        suffixIcon: suffix,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black.withOpacity(0.20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}


class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final RxString? controllerText;

  const CustomTextField({
    super.key,
    required this.label,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.controllerText,
  });

  @override
  Widget build(BuildContext context) {
    if (controllerText != null) {
      // 🔹 Only wrap the TEXT value with Obx
      return Obx(() => TextField(
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        onChanged: onChanged,
        controller: TextEditingController.fromValue(
          TextEditingValue(
            text: controllerText!.value,
            selection: TextSelection.collapsed(
              offset: controllerText!.value.length,
            ),
          ),
        ),
        decoration: InputDecoration(
          labelText: label,
          // border: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5),
          // ),
          suffixIcon: suffixIcon,
        ),
      ));
    }

    return TextField(
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5),
        // ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}