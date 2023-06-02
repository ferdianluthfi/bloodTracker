import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/sugar_level_model.dart';
import '../Services/auth_service.dart';
import '../Services/db_service.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
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
              Navigator.pushNamed(context, '/login');
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
              Provider.of<FirebaseAuthMethods>(context, listen: false)
                  .signOut(context);
              
              Navigator.popAndPushNamed(context, '/login');
            },
          )
        ],
      ),
    );
  }
}
