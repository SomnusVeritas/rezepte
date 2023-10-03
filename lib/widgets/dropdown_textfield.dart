import 'package:flutter/material.dart';

class DropdownTextfield extends StatefulWidget {
  const DropdownTextfield({super.key});

  @override
  State<DropdownTextfield> createState() => _DropdownTextfieldState();
}

class _DropdownTextfieldState extends State<DropdownTextfield> {
  List<DropdownMenuItem> get _getDropdownItems {
    return [
      const DropdownMenuItem(
        child: Text('rsitensroe'),
        value: 1,
      ),
      const DropdownMenuItem(
        child: Text('rstiersnmti'),
        value: 2,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dropdownValue = _getDropdownItems.first.value;
    return SizedBox(
      width: 500,
      child: TextField(
        decoration: InputDecoration(
            suffix: DropdownButton(
          items: _getDropdownItems,
          onChanged: _onDropdownChanged,
          value: dropdownValue,
        )),
      ),
    );
  }

  void _onDropdownChanged(value) {}
}
