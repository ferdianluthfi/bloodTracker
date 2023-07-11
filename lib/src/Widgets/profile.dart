import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Services/auth_provider.dart';

class ProfileDetail extends ConsumerWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(authStateProvider).value;
    final displayname = firebaseUser!.displayName;
    final email = firebaseUser.email;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
            readOnly: true,
            initialValue: displayname,
            style: const TextStyle(
              fontFamily: "Mohave",
            ),
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
