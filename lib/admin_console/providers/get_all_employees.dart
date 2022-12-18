import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendee/models/employee_model.dart';

class GetAllEmployeeProvider with ChangeNotifier {
  List<EmployeeModel> employeeList = [];
  bool isEmployeeLoaded = false;
  getAllEmployees({String adminId = "tTG47D04arQ3tdlq8MY5"}) async {
    try {
      Response response =
          await Dio().get("http://100.24.5.134:8000/allEmps/$adminId");
      if (response.statusCode == 200) {
        List dataList = response.data['emp_datas'];
        employeeList = dataList.map((e) => EmployeeModel.fromJson(e)).toList();
        isEmployeeLoaded = true;
        notifyListeners();
        print(employeeList);
      }
    } catch (e) {
      print(e);
    }
  }
}
