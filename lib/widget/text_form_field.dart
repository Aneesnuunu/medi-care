import 'package:flutter/material.dart';
import 'package:medi_care/Theam/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;
  final IconData? prefixIcon;

  const CustomTextFormField({
    required this.controller,
    required this.hintText,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
    this.prefixIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundColor ?? const Color(0xFF28263E),
            hintText: hintText,
            hintStyle: const TextStyle(color: AppThemeData.primaryColor),

            prefixIcon: Icon(prefixIcon ?? Icons.email,
                color: AppThemeData.primaryColor),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),

          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
