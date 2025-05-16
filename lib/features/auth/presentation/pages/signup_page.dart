// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:trafficapp/core/theme/app_pallete.dart';
import 'package:trafficapp/features/auth/presentation/pages/login_page.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_button_gradient.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_form.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phonernumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phonernumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    licenseController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/register/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_licensenumber': licenseController.text,
        'user_fname': firstNameController.text,
        'user_lname': lastNameController.text,
        'user_phonenumber': phonernumberController.text,
        'user_email': emailController.text,
        'user_password': passwordController.text,
      }),
    );
    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Welcome ${data['first_name']}!')));
      Navigator.of(context).push(LoginPage.route());
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed: ${response.body}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              AuthField(
                hintText: 'First Name',
                controller: firstNameController,
              ),
              SizedBox(height: 15),
              AuthField(hintText: 'Last Name', controller: lastNameController),
              SizedBox(height: 15),
              AuthField(
                hintText: 'Phone Number',
                controller: phonernumberController,
              ),
              SizedBox(height: 15),
              AuthField(hintText: 'Email', controller: emailController),
              SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                isObsecureText: true,
                controller: passwordController,
              ),
              SizedBox(height: 15),
              AuthField(
                hintText: 'License Number',
                controller: licenseController,
              ),
              SizedBox(height: 30),
              AuthButtonGradient(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    _registerUser();
                  }
                },
              ),
              SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(LoginPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppPallete.gradient2,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [TextSpan(text: 'Login')],
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
