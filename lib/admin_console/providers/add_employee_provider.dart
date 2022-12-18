import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddEmployeeProvider with ChangeNotifier {
  Future<String> addEmoplyee(
      {required String empPhotoUrl,
      required String empName,
      required BuildContext context,
      required String empShift}) async {
    if (empPhotoUrl.isEmpty || empName.isEmpty || empShift.isEmpty) {
      return "Please enter all fields";
    } else {
      try {
        Response res =
            await Dio().post("http://100.24.5.134:8000/addEmp", data: {
          "emp_id": "12345723",
          "admin_id": "tTG47D04arQ3tdlq8MY5",
          "emp_photourl": empPhotoUrl,
          "attendance": [],
          "overtime": [],
          "emp_name": empName,
          "emp_shift": [empShift],
          "client_id": "12345678",
          "client_name": "smartAttendance",
          "client_location": "INDIA",
          "client_sublocation": "PUNE"
        });

        if (res.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: SizedBox(
                height: 20,
                child: Center(child: Text("Employee added successfully")),
              ),
            ),
          );
          return "true";
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SizedBox(
              height: 20,
              child: Center(child: Text("Error occured")),
            ),
          ),
        );
        return "false";
      }
    }

    return "false";
  }
}
