import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final String name;
  final Function(String) onChanged;
  final String? Function(String? value)? validator;

  const TimePicker(
      {Key? key,
      required this.name,
      required this.onChanged,
      required this.validator})
      : super(key: key);

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  final dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextFormField(
        readOnly: true,
        enabled: true,
        validator: widget.validator,
        decoration: inputDecoration(),
        controller: dateController,
        onTap: () {
          _pickDate(context);
        },
      ),
    );
  }

  void _pickDate(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime != null) {
        setState(() {
          dateController.text = pickedTime.format(context);
          final timeString = "${pickedTime.hour}:${pickedTime.minute}:00";
          widget.onChanged(timeString);
        });
      }
    });
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      labelText: widget.name,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.lightBlue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
