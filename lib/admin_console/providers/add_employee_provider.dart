import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddEmployeeProvider with ChangeNotifier {
  String photoUrl = '';
  void uploadPhoto(Uint8List webImage) async {
    var firebaseStorage = FirebaseStorage.instance;
    // ignore: omit_local_variable_types
    Reference reference = firebaseStorage.ref().child('images');

    await reference
        .putData(
      webImage,
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        photoUrl = value;
      });
    });
  }

  Future<String> addEmoplyee(
      {required String empPhotoUrl,
      required String empName,
      required String empId,
      required String empMail,
      required String empPassword,
      required BuildContext context,
      required Uint8List webImage,
      required String empShift}) async {
    if (empPhotoUrl.isEmpty ||
        empName.isEmpty ||
        empShift.isEmpty ||
        empId.isEmpty ||
        empMail.isEmpty ||
        empPassword.isEmpty) {
      return "Please enter all fields";
    } else {
      try {
        // uploadPhoto(webImage);

        Response res =
            await Dio().post("http://100.24.5.134:8000/addEmp", data: {
          "emp_id": empId,
          "emp_mail": empMail,
          "emp_pwd": empPassword,
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
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: SizedBox(
                height: 20,
                child: Center(child: Text(res.data['status'].toString())),
              ),
            ),
          );
          return "false";
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
  }
}
