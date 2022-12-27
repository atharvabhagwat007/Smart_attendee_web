import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendee/models/employee_model.dart';

class AddEmployeeShiftProvider with ChangeNotifier {

  Future<bool> addEmployeeShift(
      {required EmployeeShift employeeShift,
      required BuildContext context}) async {
      try {
        // uploadPhoto(webImage);

        Response res =
            await Dio().post("http://100.24.5.134:8000/addShift", data: {
        employeeShift.toJson()
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
          return true;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: SizedBox(
                height: 20,
                child: Center(child: Text(res.data['status'].toString())),
              ),
            ),
          );
          return false;
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
        return false;
      }
  }
}
