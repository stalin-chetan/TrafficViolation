import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/app_pallete.dart';
import 'package:trafficapp/features/auth/presentation/pages/notification_page.dart';
import 'package:trafficapp/features/auth/presentation/pages/signup_page.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_button_gradient.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_form.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final licenseController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    licenseController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_licensenumber': licenseController.text,
        'user_password': passwordController.text,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Welcome ${data['user_fname']}!')));
      Navigator.of(
        context
      ).push(MaterialPageRoute(
    builder: (context) => NotificationPage(licenseNumber: licenseController.text),));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed: ${response.body}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              AuthField(
                hintText: 'License Number',
                controller: licenseController,
              ),
              SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                isObsecureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 15),
              AuthButtonGradient(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    _loginUser();
                  }
                },
              ),

              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppPallete.gradient2,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [TextSpan(text: 'Sign Up')],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
