import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_blood_tracker/src/Widgets/app_bar.dart';
import 'package:new_blood_tracker/src/Widgets/edit_profile.dart';

import '../Widgets/profile.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  var _isEditing = false;
  @override
  Widget build(BuildContext context) {
    void editToogle() {
      setState(() {
        _isEditing = !_isEditing;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
              fontSize: 30, fontFamily: "Mohave", fontWeight: FontWeight.bold),
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            const CircleAvatar(
              radius: 80,
              child: Icon(
                Icons.person,
                size: 110,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: editToogle,
              ),
            ),
            _isEditing ? EditProfileForm(cancel: editToogle,) : const ProfileDetail(),
          ],
        ),
      ),
    );
  }
}
