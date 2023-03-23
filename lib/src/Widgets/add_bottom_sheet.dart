import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  final BuildContext contextt;
  final Function startFunction;
  const AddButton(this.contextt, this.startFunction, {Key key}) : super(key: key);

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {

void sumbitData(){
  widget.startFunction(widget.contextt);
}

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => sumbitData(),
      child: const Icon(Icons.add),
    );
  }
}
