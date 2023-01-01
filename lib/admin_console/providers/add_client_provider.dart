import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_attendee/models/employee_model.dart';

class AddClientProvider with ChangeNotifier {
  List<String> selectedEmployee = [];
  bool isClientAdded = true;

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

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<String> addClient({
    required String clientId,
    required String adminId,
    required int latitude,
    required int longitude,
    required List employeeList,
    required String clientName,
    required String clientCountry,
    required String clientCity,
    required BuildContext context,
  }) async {
    isClientAdded = false;
    notifyListeners();
    try {
      Response res =
          await Dio().post("http://100.24.5.134:8000/addClient", data: {
        "client_id": clientId,
        "admin_id": adminId,
        "employees": employeeList,
        "client_name": clientName,
        "client_location": clientCountry,
        "client_sublocation": clientCity,
        "location": {"latitude": latitude, "longitude": longitude, "radius": 50}
      });
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res.data["status"].toString()),
          ),
        );
        isClientAdded = true;
        notifyListeners();
        return "true";
      }
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.response!.data["status"].toString()),
        ),
      );
      isClientAdded = true;
      notifyListeners();
      return "false";
    }
    return "";
  }
}
