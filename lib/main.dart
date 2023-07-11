import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_blood_tracker/src/screens/profile_screen.dart';

import 'firebase_options.dart';
import 'src/screens/loading_screen.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/main_screen.dart';
import 'src/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFF96746,
          <int, Color>{
            50: Color.fromRGBO(249, 103, 70, .1),
            100: Color.fromRGBO(249, 103, 70, .2),
            200: Color.fromRGBO(249, 103, 70, .3),
            300: Color.fromRGBO(249, 103, 70, .4),
            400: Color.fromRGBO(249, 103, 70, .5),
            500: Color.fromRGBO(249, 103, 70, .6),
            600: Color.fromRGBO(249, 103, 70, .7),
            700: Color.fromRGBO(249, 103, 70, .8),
            800: Color.fromRGBO(249, 103, 70, .9),
            900: Color.fromRGBO(249, 103, 70, 1),
          },
        ),
        // textTheme: TextTheme(bodyText1: TextStyle(background: font)),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const Home(),
        '/signup': (context) => EmailPasswordSignup(),
        '/login': (context) => const LoginPage(),
        '/loading': (context) => const LoadingPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
