import 'package:flutter/material.dart';
import 'package:new_blood_tracker/main.dart';

import '../Widgets/drawer.dart';
import '../Widgets/loading_animation.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // TODO: Ganti AppBar pake widget custom
        appBar: AppBar(
          leading: MyApp(),
          leadingWidth: 200,
        ),
        body: const LoadingAnimation());
  }
}
