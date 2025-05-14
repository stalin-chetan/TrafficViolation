import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/app_pallete.dart';

class AuthButtonGradient extends StatelessWidget {
  const AuthButtonGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors:
        [
          AppPallete.gradient1,
          AppPallete.gradient2,
        ])
      ),
      child: ElevatedButton(
       style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        backgroundColor: AppPallete.transparentColor,
        shadowColor: AppPallete.transparentColor,
       ),
      
       
        onPressed: (){} ,
       child: const Text('Sign Up',
       style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600
       ),
       )),
    );
  }
}