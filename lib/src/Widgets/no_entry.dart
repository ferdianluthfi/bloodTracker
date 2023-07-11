import 'package:flutter/material.dart';

class NoDataEntry extends StatelessWidget {
  const NoDataEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/empty-box.png',
          width: 200,
          height: 200,
        ),
        const Text(
          "No Data",
          style: TextStyle(
            color: Color.fromRGBO(249, 103, 70, 1),
          ),
        )
      ],
    ));
  }
}
