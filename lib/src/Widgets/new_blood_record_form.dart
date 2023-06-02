import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../Services/db_service.dart';

class AddRecordBootomSheet extends StatefulWidget {
  const AddRecordBootomSheet({Key? key}) : super(key: key);

  @override
  State<AddRecordBootomSheet> createState() => _AddRecordBootomSheetState();
}

class _AddRecordBootomSheetState extends State<AddRecordBootomSheet> {
  final bloodSugarController = TextEditingController();
  final insulinTypeController = TextEditingController();
  final insulinUnitController = TextEditingController();
  var _dateTime = DateTime.now();
  bool picked = false;

  _saveNewTrack() {
    Map<String, dynamic> temp = <String, dynamic>{
      "score": int.parse(bloodSugarController.text),
      "checkTime": Timestamp.fromDate(_dateTime),
      "type": insulinTypeController.text,
      "unitInsulin": int.parse(insulinUnitController.text),
    };
    context.read<FirestoreMethods>().addNewTrack(temp);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Container(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Text(
                  'Add New Record',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(
                // width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text("Sugar Level"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text("Type"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text("Unit"),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                          child: Text("Time"),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: MediaQuery.of(context).size.width * 0.08,
                            child: TextFormField(
                              controller: bloodSugarController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: MediaQuery.of(context).size.width * 0.08,
                            child: TextFormField(
                              controller: insulinTypeController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.44,
                            height: MediaQuery.of(context).size.width * 0.08,
                            child: TextFormField(
                              controller: insulinUnitController,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true, onConfirm: (date) {
                                setState(() {
                                  _dateTime = date;
                                  picked = true;
                                });
                              }, currentTime: _dateTime);
                            },
                            child: Text(
                              DateFormat('MMM dd, yyy HH:mm').format(_dateTime),
                              style: const TextStyle(color: Colors.blue),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: _saveNewTrack,
                    child: const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
