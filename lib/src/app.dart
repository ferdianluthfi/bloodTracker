import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_blood_tracker/src/Repository/repository.dart';
import 'Models/sugar_level_model.dart';
import 'Widgets/add_bottom_sheet.dart';
import 'Widgets/new_blood_record.dart';


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

  void _addNewTransaction(Map<String,dynamic> temp) {
    repo.addNewTrack(temp);
    setState(() {
      _refreshData();
    });
  }

  void _showNewBloodRecordField(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return AddRecordBootomSheet(_addNewTransaction);
      },
    );
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
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Blood Sugar Tracker"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshData,
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Text(scores[index].score.toString()),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Text(scores[index].type),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Text(DateFormat('MMM dd, yyy HH:mm')
                                    .format(scores[index].checkingTime)),
                              )
                            ],
                          ),
                        );
                      }),
                      itemCount: scores.length,
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: AddButton(context, _showNewBloodRecordField),
          );
        } else {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Blood Sugar Tracker"),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Loading ...",),
                    SizedBox(height: 10,),
                    CircularProgressIndicator(),
                  ],
                ),
              ));
        }
      },
    );
  }
}
