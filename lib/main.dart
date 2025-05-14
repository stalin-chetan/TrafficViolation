import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/theme.dart';
import 'package:trafficapp/features/auth/presentation/pages/login_page.dart';
import 'package:trafficapp/features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),

    );
  }
}
