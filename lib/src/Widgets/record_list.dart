import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/sugar_level_model.dart';

class RecordList extends StatefulWidget {
  final _updateFunction;
  final Map<DateTime, List<SugarBloodScore>> _scores;
  const RecordList(this._updateFunction, this._scores, {Key? key})
      : super(key: key);

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: widget._updateFunction,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                color: Color.fromRGBO(163, 163, 163, 1),
                indent: 20,
                endIndent: 20,
              ),
              itemCount: widget._scores.length,
              itemBuilder: ((context, index) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        DateFormat('MMM dd, yyy')
                            .format(widget._scores.keys.elementAt(index)),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.fromLTRB(20, 5, 20, 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 3,
                      child: ListView.separated(
                        reverse: true,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Color.fromRGBO(163, 163, 163, 1),
                          indent: 25,
                          endIndent: 25,
                        ),
                        itemCount: widget
                            ._scores[widget._scores.keys.elementAt(index)]!
                            .length,
                        itemBuilder: ((context, idx) {
                          final item = widget
                              ._scores[widget._scores.keys.elementAt(index)];

                          final record = widget
                              ._scores[widget._scores.keys.elementAt(index)]!
                              .elementAt(idx);

                          return Dismissible(
                            direction: DismissDirection.endToStart,
                            // Show a red background as the item is swiped away
                            background: Card(
                              color: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 0,
                            ),
                            key: Key(item!.elementAt(idx).id),
                            onDismissed: (direction) {
                              // Remove the item from the data source.
                              setState(() {
                                item.removeAt(idx);
                                //To Do: Learn how to user provider to pass data in the firebase store across the app
                              });

                              // Show a snackbar. This snackbar could also contain "Undo" actions.
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "${DateFormat('MMM dd, yyy HH:mm').format(record.checkingTime)} dismissed")));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 0,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      child: Text(
                                        record.score.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      child: Text(DateFormat('HH:mm')
                                          .format(record.checkingTime)),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 10),
                                      child: record.type == ""
                                          ? const Text("")
                                          : Text(
                                              record.type,
                                              textAlign: TextAlign.end,
                                            ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 15, 25, 10),
                                      child: record.type == ""
                                          ? const Text("")
                                          : Text(
                                              "${record.unitInsulin} Unit",
                                              textAlign: TextAlign.end,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
