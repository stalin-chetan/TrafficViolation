import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/app_pallete.dart';
import 'package:trafficapp/features/auth/presentation/pages/signup_page.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_button_gradient.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_form.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              AuthField(hintText: 'Email'),
              SizedBox(height: 15),
              AuthField(hintText: 'Password', isObsecureText: true),
              SizedBox(height: 15),
              AuthButtonGradient(),
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
