import 'package:flutter/material.dart';
import 'package:trafficapp/core/theme/app_pallete.dart';
import 'package:trafficapp/features/auth/presentation/pages/login_page.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_button_gradient.dart';
import 'package:trafficapp/features/auth/presentation/widgets/auth_form.dart';

class SignUpPage extends StatefulWidget {
    static route() =>  MaterialPageRoute(builder: (context)=> SignUpPage());

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final licenseController = TextEditingController();
final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    licenseController.dispose();
    super.dispose();
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
              AuthField(hintText: 'Name'),
              SizedBox(height: 15),
              AuthField(hintText: 'Email'),
              SizedBox(height: 15),
              AuthField(hintText: 'Password', isObsecureText: true,),
              SizedBox(height: 15),
              AuthField(hintText: 'License Number'),
              SizedBox(height: 30),
              AuthButtonGradient(),
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
