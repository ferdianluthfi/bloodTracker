import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/sugar_level_model.dart';

class RecordList extends StatefulWidget {
  final VoidCallback _updateFunction;
  final Map<DateTime, List<SugarBloodScore>> _scores;
  const RecordList(this._updateFunction, this._scores, {Key key})
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
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          color: Color.fromRGBO(163, 163, 163, 1),
                          indent: 25,
                          endIndent: 25,
                        ),
                        itemCount: widget
                            ._scores[widget._scores.keys.elementAt(index)]
                            .length,
                        itemBuilder: ((context, idx) {
                          return Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(
                                    widget._scores[widget._scores.keys
                                            .elementAt(index)]
                                        .elementAt(idx)
                                        .score
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Text(DateFormat('HH:mm').format(widget
                                      ._scores[
                                          widget._scores.keys.elementAt(index)]
                                      .elementAt(idx)
                                      .checkingTime)),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: widget._scores[widget._scores.keys
                                                      .elementAt(index)]
                                                  .elementAt(idx)
                                                  .type ==
                                              null ||
                                          widget._scores[widget._scores.keys
                                                      .elementAt(index)]
                                                  .elementAt(idx)
                                                  .type ==
                                              ""
                                      ? const Text("")
                                      : Text(
                                          widget._scores[widget._scores.keys
                                                  .elementAt(index)]
                                              .elementAt(idx)
                                              .type,
                                          textAlign: TextAlign.end,
                                        ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 15, 25, 10),
                                  child: widget._scores[widget._scores.keys
                                                      .elementAt(index)]
                                                  .elementAt(idx)
                                                  .type ==
                                              null ||
                                          widget._scores[widget._scores.keys
                                                      .elementAt(index)]
                                                  .elementAt(idx)
                                                  .type ==
                                              ""
                                      ? const Text("")
                                      : Text(
                                          "${widget._scores[widget._scores.keys.elementAt(index)].elementAt(idx).unitInsulin} Unit",
                                          textAlign: TextAlign.end,
                                        ),
                                ),
                              ),
                            ],
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
