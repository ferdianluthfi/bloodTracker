import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_blood_tracker/src/Widgets/app_bar.dart';
import 'package:new_blood_tracker/src/Widgets/loading_animation.dart';
import 'package:new_blood_tracker/src/Widgets/record_list.dart';
import 'package:new_blood_tracker/src/screens/onboarding_screen.dart';

import '../Services/auth_provider.dart';
import '../Services/db_provider.dart';
import '../Widgets/button_show_record_form.dart';
import '../Widgets/drawer.dart';
import '../Widgets/no_entry.dart';
import 'login_screen.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);
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
  Widget build(BuildContext context, WidgetRef ref) {
    var database = ref.watch(recordsListProvider).value;
    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const MyAppBar(),

              ),
              endDrawer: const AppDrawer(),
              body: database == null || database == {}
                  ? const NoDataEntry()
                  : RecordList(temptFunction, database),
              floatingActionButton: const AddButton(),
            );
          }
          return const OnboardingPage();
        },
        loading: () => const LoadingAnimation(),
        error: (e, trace) => const LoadingAnimation());
  }
}
