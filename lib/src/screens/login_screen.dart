import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Services/auth_service.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Image.asset(
            'assets/AppBarLogo.png',
          ),
        ),
        leadingWidth: 200,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign In",
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
                if (value == null || value.trim().isEmpty || !value.contains("@")) {
                  return 'Please enter a valid email';
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
          Column(
            children: [
              Center(
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/loading');
                    Provider.of<FirebaseAuthMethods>(context, listen: false)
                        .loginWithEmail(
                            email: emailController.text,
                            password: passwordController.text,
                            context: context);
                    Navigator.popAndPushNamed(context, '/');
                  },
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Or create a "),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        "New Account",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
