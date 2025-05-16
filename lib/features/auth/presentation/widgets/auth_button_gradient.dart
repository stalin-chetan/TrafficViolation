import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/app_pallete.dart';

class AuthButtonGradient extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const AuthButtonGradient({
    super.key,
    required this.onTap,
    this.text = 'Sign Up',
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // <- This must be connected!
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
