import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:smart_attendee/admin_console/add_employee.dart';

class AdminConsole extends StatelessWidget {
  const AdminConsole({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context, builder: ((context) => AddEmployee()));
                },
                child: Text('add emoployee'))
          ],
        ),
      ),
    );
  }
}
