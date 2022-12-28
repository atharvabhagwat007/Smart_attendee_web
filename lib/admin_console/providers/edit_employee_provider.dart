import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class EditEmployeeProvider with ChangeNotifier {
  Future<bool> editEmployee(
      {required String employeeId,
      required Map<String, dynamic> json,
      required BuildContext context}) async {
    try {
      Response res = await Dio().post(
          "http://100.24.5.134:8000/editEmp/$employeeId/",
          data: json);

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SizedBox(
              height: 20,
              child: Center(child: Text("Employee updated successfully")),
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
