import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../Models/sugar_level_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRecordBootomSheet extends StatefulWidget {
  final Function saveTrack;
  const AddRecordBootomSheet(this.saveTrack, {Key key}) : super(key: key);

  @override
  State<AddRecordBootomSheet> createState() => _AddRecordBootomSheetState();
}

class _AddRecordBootomSheetState extends State<AddRecordBootomSheet> {
  final bloodSugarController = TextEditingController();
  CheckType myCheckType = CheckType.BANGUN_TIDUR;
  var _dateTime = DateTime.now();

  _saveNewTrack() {

    Map<String,dynamic> temp = <String,dynamic>{
      "score": int.parse(bloodSugarController.text),
      "checkTime": Timestamp.fromDate(_dateTime),
      "type": myCheckType.name,
    };

    widget.saveTrack(temp);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Record',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
                TextFormField(
                  controller: bloodSugarController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration:
                      const InputDecoration(labelText: "Blood Sugar Level"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton<CheckType>(
                      isExpanded: true,
                      value: myCheckType,
                      items: CheckType.values.map((CheckType checkType) {
                        return DropdownMenuItem<CheckType>(
                            alignment: AlignmentDirectional.center,
                            value: checkType,
                            child: Text(checkType.name));
                      }).toList(),
                      onChanged: (CheckType newValue) {
                        setState(() {
                          myCheckType = newValue;
                        });
                      }),
                ),
                Container(
                  alignment: AlignmentDirectional.centerEnd,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                      onPressed: () {
                        DatePicker.showDateTimePicker(context,
                            showTitleActions: true, onConfirm: (date) {
                          setState(() {
                            _dateTime = date;
                          });
                        }, 
                        
                        currentTime: _dateTime);
                      },
                      child: const Text(
                        'Choose Time',
                        style: TextStyle(color: Colors.blue),
                      )),
                )
              ],
            ),
            ElevatedButton(
              onPressed: _saveNewTrack,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
