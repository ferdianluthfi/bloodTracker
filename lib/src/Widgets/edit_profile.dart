import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/auth_provider.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  VoidCallback cancel;
  EditProfileForm({Key? key, required this.cancel}) : super(key: key);

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  @override
  Widget build(BuildContext context) {
    String initialName = ref.read(authStateProvider).value!.displayName!;
    String initialEmail = ref.read(authStateProvider).value!.email!;
    final TextEditingController emailController =
        TextEditingController.fromValue(TextEditingValue(text: initialEmail));

    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    final TextEditingController displaynameController =
        TextEditingController.fromValue(TextEditingValue(text: initialName));

    void updateUser() {
      Navigator.pushNamed(context, '/loading');
      print(emailController.text);
      ref.read(authenticationProvider).updateAccount(
            email: emailController.text,
            password: passwordController.text,
            displayName: displaynameController.text,
            context: context,
          );
      // if (emailController.value!=null) {
        
      // }
      ref.read(authenticationProvider).signOut(context);
      Navigator.popAndPushNamed(context, '/');
    }

    return Column(
      children: [
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
              labelText: 'Name',
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
              labelText: 'Email',
              hintText: "Enter your email",
            ),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            style: const TextStyle(
              fontFamily: "Mohave",
            ),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: "Enter your NEW Password",
            ),
            controller: passwordController,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            validator: (value) {
              if (value != passwordController.text) {
                return 'password do not match!';
              }
              return null;
            },
            style: const TextStyle(
              fontFamily: "Mohave",
            ),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
              hintText: "Enter your NEW Password",
            ),
            controller: confirmPasswordController,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: widget.cancel,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                      fontFamily: "Mohave", fontWeight: FontWeight.bold),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 4, 40),
                ),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: updateUser,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                  ),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                      fontFamily: "Mohave", fontWeight: FontWeight.bold),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width / 4, 40),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
