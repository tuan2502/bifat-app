import 'package:flutter/material.dart';

class CheckBoxFast extends StatefulWidget {
  const CheckBoxFast({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  _CheckBoxFast createState() => _CheckBoxFast();
}

class _CheckBoxFast extends State<CheckBoxFast> {
  bool valuefirst = false;
  bool valuesecond = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: valuefirst,
          onChanged: (bool? value) {
            setState(() {
              valuefirst = value ?? false;
            });
          },
        ),
        Text(
          widget.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
