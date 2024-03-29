import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:new_blood_tracker/src/Services/db_provider.dart';

import 'snackbar.dart';

class AddRecordBootomSheet extends ConsumerStatefulWidget {
  const AddRecordBootomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<AddRecordBootomSheet> createState() =>
      _AddRecordBootomSheetState();
}

class _AddRecordBootomSheetState extends ConsumerState<AddRecordBootomSheet> {
  final bloodSugarController = TextEditingController();
  final insulinUnitController = TextEditingController();
  var _dateTime = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  bool picked = false;
  String? dropdownValue = "No Injection";
  List<String> insulinItems = [
    "No Injection",
    "Actrapid",
    "Apidra",
    "Basaglar",
    "Fiasp",
    "Humulin",
    "Lantus",
    "Levemir",
    "NovoLog",
    "Novolin",
    "Novorapid",
    "Toujeo",
    "Tresiba",
    "Others"
  ];

  _saveNewTrack() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> temp = <String, dynamic>{
        "score": int.parse(bloodSugarController.text),
        "checkTime": Timestamp.fromDate(_dateTime),
        "type": dropdownValue == "No Injection"
            ? ""
            : dropdownValue!.substring(0, 3),
        "unitInsulin": insulinUnitController.text.isNotEmpty
            ? int.parse(insulinUnitController.text)
            : 0,
      };
      ref.read(databaseProvider).addNewTrack(temp);
      Navigator.of(context).pop();
    }
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
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.44,
                              height: MediaQuery.of(context).size.width * 0.08,
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    Navigator.of(context).pop();
                                    showSnackBar(context,
                                        "Please fill your sugar blood level!");
                                    return "";
                                  }
                                  return null;
                                },
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
                                height:
                                    MediaQuery.of(context).size.width * 0.08,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: dropdownValue,
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: insulinItems
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Center(child: Text(value)),
                                    );
                                  }).toList(),
                                )

                                // TextFormField(
                                //   controller: insulinTypeController,
                                //   textAlign: TextAlign.center,
                                //   keyboardType: TextInputType.text,
                                //   decoration: InputDecoration(
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(25.0),
                                //     ),
                                //   ),
                                // ),

                                ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(5),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.44,
                              height: MediaQuery.of(context).size.width * 0.08,
                              child: TextFormField(
                                validator: (value) {
                                  if (dropdownValue != "No Injection" &&
                                      (insulinUnitController.text.isEmpty ||
                                          value == null)) {
                                    Navigator.of(context).pop();
                                    showSnackBar(context,
                                        "Please fill your injection unit!");
                                    return "null";
                                  }
                                  return null;
                                },
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
                                DateFormat('MMM dd, yyy HH:mm')
                                    .format(_dateTime),
                                style: const TextStyle(color: Colors.blue),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
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
