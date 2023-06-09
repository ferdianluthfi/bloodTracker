import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../Models/sugar_level_model.dart';
import '../Services/db_provider.dart';

class RecordList extends ConsumerStatefulWidget {
  final _updateFunction;
  final Map<DateTime, List<SugarBloodScore>> _scores;
  const RecordList(this._updateFunction, this._scores, {Key? key})
      : super(key: key);

  @override
  ConsumerState<RecordList> createState() => _RecordListState();
}

class _RecordListState extends ConsumerState<RecordList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: widget._updateFunction,
            child: widget._scores.isEmpty
                ? Center(
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
                  ))
                : ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Color.fromRGBO(163, 163, 163, 1),
                      indent: 20,
                      endIndent: 20,
                    ),
                    itemCount: widget._scores.length,
                    itemBuilder: ((context, index) {
                      return Dismissible(
                        key: Key('item $index'),
                        onDismissed: (direction) {
                          // Remove the item from the data source.
                          setState(() {
                            widget._scores
                                .remove(widget._scores.keys.elementAt(index));
                          });
                        },
                        child: Visibility(
                          visible: widget
                              ._scores[widget._scores.keys.elementAt(index)]!
                              .isNotEmpty,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 5),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  DateFormat('MMM dd, yyy').format(
                                      widget._scores.keys.elementAt(index)),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Card(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 5, 20, 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 3,
                                child: ListView.separated(
                                  reverse: true,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Color.fromRGBO(163, 163, 163, 1),
                                    indent: 25,
                                    endIndent: 25,
                                  ),
                                  itemCount: widget
                                      ._scores[
                                          widget._scores.keys.elementAt(index)]!
                                      .length,
                                  itemBuilder: ((context, idx) {
                                    final listRecordOfTheDay = widget._scores[
                                        widget._scores.keys.elementAt(index)];

                                    final record = widget._scores[widget
                                            ._scores.keys
                                            .elementAt(index)]!
                                        .elementAt(idx);

                                    return Dismissible(
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.red,
                                                spreadRadius: 0.15),
                                          ],
                                        ),
                                      ),
                                      key: Key(listRecordOfTheDay!
                                          .elementAt(idx)
                                          .id),
                                      onDismissed: (direction) {
                                        // Remove the item from the data source.
                                        setState(() {
                                          ref
                                              .read(databaseProvider)
                                              .deleteTrack(listRecordOfTheDay
                                                  .elementAt(idx)
                                                  .id);
                                          listRecordOfTheDay.removeAt(idx);
                                        });
                                        // Show a snackbar. This snackbar could also contain "Undo" actions.
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "${DateFormat('MMM dd, yyy HH:mm').format(record.checkingTime)} dismissed")));
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        elevation: 0,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                child: Text(
                                                  record.score.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                child: Text(DateFormat('HH:mm')
                                                    .format(
                                                        record.checkingTime)),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25,
                                                        vertical: 10),
                                                child: record.type == ""
                                                    ? const Text("")
                                                    : Text(
                                                        record.type,
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 15, 25, 10),
                                                child: record.type == ""
                                                    ? const Text("")
                                                    : Text(
                                                        "${record.unitInsulin} Unit",
                                                        textAlign:
                                                            TextAlign.end,
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
                          ),
                        ),
                      );
                    }),
                  ),
          ),
        ),
      ],
    );
  }
}
