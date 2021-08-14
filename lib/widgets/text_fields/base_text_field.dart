import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? label;
  final String? hintText;
  final bool? obscureText;
  const BaseTextField({
    Key? key,
    required this.controller,
    required this.validator,
    this.label,
    this.hintText,
    this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        labelText: label,
        hintText: hintText,
      ),
    );
  }
}
