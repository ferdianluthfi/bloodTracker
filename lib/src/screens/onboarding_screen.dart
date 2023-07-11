import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_blood_tracker/src/Services/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:new_blood_tracker/src/screens/login_screen.dart';

import '../Widgets/app_bar.dart';
import 'signup_screen.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoggingIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const MyAppBar(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isLoggingIn ? const LoginPage() : EmailPasswordSignup(),
          isLoggingIn
              ? Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Or create a "),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLoggingIn = false;
                          });
                        },
                        child: const Text(
                          "New Account",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Already have an account? "),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isLoggingIn = true;
                          });
                        },
                        child: const Text(
                          "Login instead",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
