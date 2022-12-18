import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_attendee/admin_console/admin_console.dart.dart';
import 'package:smart_attendee/admin_console/providers/get_all_employees.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Attendee',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
          create: (context) => GetAllEmployeeProvider(), child: AdminConsole()),
    );
  }
}
