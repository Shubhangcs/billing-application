import 'package:flutter/material.dart';
import 'package:new_billing/core/themes/colors.dart';


class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool obscureText;
  const CustomTextField({super.key , required this.labelText , required this.controller , this.obscureText = false , this.onTap , this.readOnly = false,});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      onTap: onTap,
      cursorColor: AppColors.blue,
      cursorHeight: 18,
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
      ),
    );
  }
}