import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendee/models/employee_model.dart';

class AddClientProvider with ChangeNotifier {
  List<String> selectedEmployee = [];

  void selectEmployee(EmployeeModel currentEmployee) {
    if (currentEmployee.isSelected) {
      selectedEmployee.remove(currentEmployee.empId.toString());
      notifyListeners();
    } else {
      selectedEmployee.add(currentEmployee.empId.toString());
      notifyListeners();
    }
    print(selectedEmployee);
  }

  Future<String> addClient({
    required String clientId,
    required String adminId,
    required List employeeList,
    required String clientName,
    required String clientCountry,
    required String clientCity,
    required BuildContext context,
  }) async {
    try {
      Response res =
          await Dio().post("http://100.24.5.134:8000/addClient", data: {
        "client_id": clientId,
        "admin_id": adminId,
        "employees": employeeList,
        "client_name": clientName,
        "client_location": clientCountry,
        "client_sublocation": clientCity,
      });
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.data["status"].toString()),
          ),
        );
        return "true";
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data["status"].toString()),
        ),
      );
      return "false";
    }
    return "";
  }
}
