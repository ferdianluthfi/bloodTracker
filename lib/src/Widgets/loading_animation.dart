import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Loading ...",
              ),
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(),
            ],
          ),
        );
  }
}