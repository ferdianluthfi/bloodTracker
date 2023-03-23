import 'package:flutter/material.dart';
import 'package:new_blood_tracker/src/Repository/repository.dart';
import 'package:new_blood_tracker/src/Widgets/loading_screen.dart';
import 'package:new_blood_tracker/src/Widgets/record_list.dart';
import 'Models/sugar_level_model.dart';
import 'Widgets/add_bottom_sheet.dart';
import 'Widgets/new_blood_record_form.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
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
  List<SugarBloodScore> scores;
  Future<void> _initFuture;
  Repository repo = Repository();

  @override
  void initState() {
    super.initState();
    _initFuture = _initAsync();
  }

  Future<void> _initAsync() async {
    await repo.fetchAllScores().then((value) => scores = value);
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
        title: const Text("Blood Sugar Tracker"),
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
