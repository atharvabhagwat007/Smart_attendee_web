import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendee/models/employee_model.dart';

class GetEmployeeProvider with ChangeNotifier {
  late EmployeeModel employee;
  bool isEmployeeLoaded = false;
  getEmployee(
      {String adminId = "tTG47D04arQ3tdlq8MY5",
      required String employeeId}) async {
    try {
      Response response =
          await Dio().get("http://100.24.5.134:8000/getEmp/$employeeId");
      if (response.statusCode == 200) {
        final data = response.data['emp_data'];
        employee = EmployeeModel.fromJson(data);
        isEmployeeLoaded = true;

        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
