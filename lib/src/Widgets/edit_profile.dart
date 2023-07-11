import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/auth_provider.dart';
import 'snackbar.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  final VoidCallback cancel;
  const EditProfileForm({Key? key, required this.cancel}) : super(key: key);

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  late final TextEditingController displaynameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    displaynameController = TextEditingController(
        text: ref.read(authStateProvider).value!.displayName!);
  }

  @override
  Widget build(BuildContext context) {
    void updateUser() {
      if (_formKey.currentState!.validate()) {
        ref.read(authenticationProvider).updateName(
              displayName: displaynameController.text,
              context: context,
            );
        if (passwordController.text.isNotEmpty) {
          ref.read(authenticationProvider).updatePassword(
                oldpassword: oldPasswordController.text,
                password: passwordController.text,
                context: context,
              );
        }

        showSnackBar(context, "Profile berhasil diperbarui");
        Navigator.pop(context);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
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
              keyboardType: TextInputType.name,
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (value) {
                if (passwordController.text.isNotEmpty &&
                    (value == null || value.isEmpty)) {
                  return 'Please enter your current password';
                }
                return null;
              },
              style: const TextStyle(
                fontFamily: "Mohave",
              ),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                hintText: "Enter your Current Password",
              ),
              controller: oldPasswordController,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              validator: (value) {
                if (oldPasswordController.text.isNotEmpty &&
                    (value == null || value.isEmpty)) {
                  return 'Please enter your full new password';
                }
                return null;
              },
              style: const TextStyle(
                fontFamily: "Mohave",
              ),
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
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
      ),
    );
  }
}
