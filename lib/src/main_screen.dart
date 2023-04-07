import 'package:flutter/material.dart';
import 'package:new_blood_tracker/src/Repository/repository.dart';
import 'package:new_blood_tracker/src/Widgets/loading_screen.dart';
import 'package:new_blood_tracker/src/Widgets/record_list.dart';
import 'package:new_blood_tracker/src/profile_screen.dart';
import 'Models/sugar_level_model.dart';
import 'Widgets/add_bottom_sheet.dart';
import 'Widgets/new_blood_record_form.dart';
import './profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
      home: const Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<DateTime, List<SugarBloodScore>> scores;
  Future<void> _initFuture;
  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    _initFuture = _initAsync();
  }

  Future<void> _initAsync() async {
    await repo.fetchAllScores().then((value) {
      scores = value;
    });
  }

  void _addNewTransaction(Map<String, dynamic> temp) {
    repo.addNewTrack(temp);
    setState(() {
      _refreshData();
    });
  }

  void _showNewBloodRecordField(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return AddRecordBootomSheet(_addNewTransaction);
        });
  }

  Future<void> _refreshData() async {
    // Fetch new data from the server
    final newData = await repo.fetchAllScores().then((value) => scores = value);

    // Update the UI
    setState(() {
      scores = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Image.asset(
            'assets/AppBarLogo.png',
          ),
        ),
        leadingWidth: 200,
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              //TODO: Create getter for the user's name
              child: const Text(
                "Hello, Luthfi Ferdian!",
                style: TextStyle(
                    fontFamily: 'Mohave',
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Navigate to second screen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text('About Us'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: _initFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return RecordList(_refreshData, scores);
          } else {
            return const LoadingAnimation();
          }
        },
      ),
      floatingActionButton: AddButton(context, _showNewBloodRecordField),
    );
  }
}
