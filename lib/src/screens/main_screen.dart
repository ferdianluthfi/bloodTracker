import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_blood_tracker/src/Widgets/app_bar.dart';
import 'package:new_blood_tracker/src/Widgets/record_list.dart';
import 'package:provider/provider.dart';

import '../Models/sugar_level_model.dart';
import '../Widgets/button_show_record_form.dart';
import '../Widgets/drawer.dart';
import '../Widgets/no_entry.dart';
import 'login_screen.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

/*
  // TODO: bikin refresh data manual untuk refresh indicator(?)
  // Future<void> _refreshData() async {
  //   // Fetch new data from the server
  //   final newData = await repo.fetchAllScores().then((value) => scores = value);

  //   // Update the UI
  //   setState(() {
  //     scores = newData;
  //   });
  // }
  */

  Future<void> temptFunction() async {}
  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<SugarBloodScore>>? database;

    return Consumer<User?>(
      builder: (context, user, _) {
        

        if (user != null) {
          database =
              Provider.of<Map<DateTime, List<SugarBloodScore>>?>(context);
          return Scaffold(
            // TODO: Ganti AppBar pake widget custom
            appBar: AppBar(
              leading: MyAppBar(),
              leadingWidth: 200,
            ),
            endDrawer: AppDrawer(),
            body: database == null
                ? const NoDataEntry()
                : RecordList(temptFunction, database!),

            floatingActionButton: const AddButton(),
          );
        }
        print("ini db nya pas log out: $database");

        /// other way there is no user logged.
        return LoginPage();
      },
    );
  }
}
