import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String? labelText;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  // final String? errorText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  // final bool autoFocus;
  final bool obscureText;
  final TextEditingController controller;
  const InputField({
    this.labelText,
    this.onChanged,
    this.onSubmitted,
    // this.errorText,
    this.keyboardType,
    this.textInputAction,
    // this.autoFocus = false,
    this.obscureText = false,
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      // autofocus: autoFocus,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        // errorText: errorText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
