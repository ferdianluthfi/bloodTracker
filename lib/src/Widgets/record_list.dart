import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/sugar_level_model.dart';

class RecordList extends StatefulWidget {
  final VoidCallback _updateFunction;
  final List<SugarBloodScore> _scores;
  const RecordList(this._updateFunction,this._scores, {Key key}) : super(key: key);

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
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(widget._scores[index].score.toString()),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(widget._scores[index].type),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Text(DateFormat('MMM dd, yyy HH:mm')
                            .format(widget._scores[index].checkingTime)),
                      ),
                    ],
                  ),
                );
              }),
              itemCount: widget._scores.length,
            ),
          ),
        ),
      ],
    );
  }
}
