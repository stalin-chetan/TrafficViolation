import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObsecureText;
  final TextEditingController? controller;

  const AuthField({
    super.key,
    required this.hintText,
    this.isObsecureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObsecureText,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Enter $hintText' : null,
    );
  }
}
