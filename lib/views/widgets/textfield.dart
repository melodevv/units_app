import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final TextEditingController controller;
  final Widget prefixIcon;
  const InputField({
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    required this.prefixIcon,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.yellow,
      cursorWidth: 3,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(color: Color.fromRGBO(38, 38, 38, 1)),
      decoration: InputDecoration(
        prefixIconColor: Colors.grey[500],
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: const TextStyle(color: Color.fromRGBO(200, 200, 200, 1)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.yellow, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.yellow),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
