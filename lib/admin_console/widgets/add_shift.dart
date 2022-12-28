import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/widgets/time_picker.dart';
import 'package:smart_attendee/models/employee_model.dart';

import '../providers/add_employee_shift.dart';
import 'date_picker.dart';

class AddShift extends StatefulWidget {
  final String employeeId;
  final Function callback;
  const AddShift({Key? key, required this.employeeId, required this.callback})
      : super(key: key);
  @override
  _AddShiftState createState() => _AddShiftState();
}

class _AddShiftState extends State<AddShift> {
  final _formKey = GlobalKey<FormState>();

  late DateTime shiftDate;
  late String shiftFrom;
  late String shiftTo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddEmployeeShiftProvider(),
      builder: (context, child) => AlertDialog(
        title: const Text('Shift'),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: <Widget>[
                DatePicker(
                    name: 'Date',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter the Shift Date';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      shiftDate = text;
                    }),
                TimePicker(
                  name: 'Shift From',
                  onChanged: (text) {
                    shiftFrom = text;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Shift From Time';
                    }
                    return null;
                  },
                ),
                TimePicker(
                  name: 'Shift To',
                  onChanged: (text) {
                    shiftTo = text;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter the Shift To Time';
                    }
                    return null;
                  },
                )
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final newShift = EmployeeShift(
                    date: DateFormat('dd/MM/yyyy').format(shiftDate),
                    shiftFrom: shiftFrom,
                    shiftTo: shiftTo);
                context
                    .read<AddEmployeeShiftProvider>()
                    .addEmployeeShift(
                      employeeId: widget.employeeId,
                      employeeShift: newShift,
                      context: context,
                    )
                    .then((value) {
                  if (value) {
                    widget.callback();
                    Navigator.of(context).pop();
                  }
                });
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
