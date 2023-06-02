import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_blood_tracker/src/Widgets/app_bar.dart';
import 'package:provider/provider.dart';
import '../Services/auth_service.dart';

class EmailPasswordSignup extends StatefulWidget {
  static String routeName = '/signup-email-password';
  const EmailPasswordSignup({Key? key}) : super(key: key);

  @override
  _EmailPasswordSignupState createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displaynameController = TextEditingController();

  void signUpUser() {
    Navigator.pushNamed(context, '/loading');
    context.read<FirebaseAuthMethods>().signUpWithEmail(
          email: emailController.text,
          password: passwordController.text,
          displayName: displaynameController.text,
          context: context,
        );
  }

  void navigateUserToHome() {
    Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyAppBar(),
        leadingWidth: 200,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 30,
                fontFamily: "Mohave",
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
              style: const TextStyle(
                fontFamily: "Mohave",
              ),
              decoration: const InputDecoration(
                labelText: 'Name *',
                hintText: "Enter your full name",
              ),
              controller: displaynameController,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              style: const TextStyle(
                fontFamily: "Mohave",
              ),
              decoration: const InputDecoration(
                labelText: 'Email *',
                hintText: "Enter your email",
              ),
              controller: emailController,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              style: const TextStyle(
                fontFamily: "Mohave",
              ),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password *',
                hintText: "Enter your Password",
              ),
              controller: passwordController,
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: signUpUser,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                    fontFamily: "Mohave", fontWeight: FontWeight.bold),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
