import 'package:flutter/material.dart';

class NoDataEntry extends StatelessWidget {
  const NoDataEntry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.not_interested_rounded,size: 24),
    );
  }
}