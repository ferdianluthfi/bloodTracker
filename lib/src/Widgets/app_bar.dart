import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
      child: SizedBox(
        width: 143.3,
        child: Image.asset(
          'assets/AppBarLogo.png',
        ),
      ),
    );
  }
}
