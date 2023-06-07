import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import '../Services/auth_provider.dart';

class AppDrawer extends ConsumerWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firebaseUser = ref.watch(authStateProvider).value;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: firebaseUser != null
                ? Text(
                    "Hello, ${firebaseUser.displayName}",
                    style: const TextStyle(
                        fontFamily: 'Mohave',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  )
                : const Text(
                    "Welcome to SweetSight!",
                    style: TextStyle(
                        fontFamily: 'Mohave',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('About Us'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.53),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log Out'),
            onTap: () {
              ref.read(authenticationProvider).signOut(context);
              Navigator.popAndPushNamed(context, '/login');
            },
          )
        ],
      ),
    );
  }
}
