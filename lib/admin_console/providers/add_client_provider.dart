import 'package:flutter/material.dart';
import 'package:smart_attendee/models/employee_model.dart';

class AddClientProvider with ChangeNotifier {
  List<EmployeeModel> selectedEmployee = [];

  selectEmployee(EmployeeModel currentEmployee) {
    if (currentEmployee.isSelected) {
      selectedEmployee.remove(currentEmployee);
      notifyListeners();
    } else {
      selectedEmployee.add(currentEmployee);
      notifyListeners();
    }
    print(selectedEmployee);
  }
}
