import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen Two'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Go back to Screen One'),
          onPressed: () {
            // Navigate back to first screen when tapped
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}