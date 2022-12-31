import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditEmployeeProvider with ChangeNotifier {
  String photoUrl = '';
  Future uploadPhoto(
    Uint8List webImage,
    String empId,
    BuildContext context,
  ) async {
    var firebaseStorage = FirebaseStorage.instance;
    // ignore: omit_local_variable_types
    Reference reference = firebaseStorage.ref("employees/$empId/profile");

    await reference
        .putData(
      webImage,
      SettableMetadata(contentType: 'image/jpeg'),
    )
        .whenComplete(() async {
      await reference.getDownloadURL().then((value) {
        photoUrl = value;
      }).onError((error, stackTrace) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload image"),
          ),
        );
      });
    });
  }

  Future<bool> editEmployee({
    required String employeeId,
    required Map<String, dynamic> json,
    required BuildContext context,
    required Uint8List webImage,
  }) async {
    try {
      await uploadPhoto(webImage, employeeId, context);
      Response res = await Dio().post(
        "http://100.24.5.134:8000/editEmp/$employeeId/",
        data: json,
      );

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: SizedBox(
              height: 20,
              child: Center(
                child: Text("Employee updated successfully"),
              ),
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
