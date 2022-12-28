import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_attendee/models/client_model.dart';

class GetAllClientProvider with ChangeNotifier {
  List<Client> clientList = [];
  int employeeCount = 0;
  bool isClientLoaded = false;
  getAllClients({String adminId = "tTG47D04arQ3tdlq8MY5"}) async {
//    try {
    Response response =
        await Dio().get("http://100.24.5.134:8000/allClients/$adminId");
    if (response.statusCode == 200) {
      List dataList = response.data['client_datas'];
      clientList = dataList.map((e) => Client.fromJson(e)).toList();
      employeeCount = clientList.length;
      isClientLoaded = true;

      notifyListeners();
    }
    // } catch (e) {
    //   print(e);
    // }
  }
}
