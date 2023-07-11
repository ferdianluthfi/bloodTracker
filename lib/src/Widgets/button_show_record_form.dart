import 'package:flutter/material.dart';

import 'new_blood_record_form.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

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
          return const AddRecordBootomSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => _showNewBloodRecordField(context),
      child: const Icon(Icons.add),
    );
  }
}
