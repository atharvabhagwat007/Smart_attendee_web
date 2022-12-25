// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromJson(jsonString);

import 'dart:convert';

class EmployeeModel {
  EmployeeModel({
    required this.isSelected,
    required this.attendance,
    required this.clientId,
    required this.clientLocation,
    required this.clientName,
    required this.clientSublocation,
    required this.empId,
    required this.empMail,
    required this.empName,
    required this.empPhotourl,
    required this.empPwd,
    required this.empShift,
    required this.overtime,
  });

  final List<Attendance> attendance;
  final String clientId;
  final String clientLocation;
  final String clientName;
  final String clientSublocation;
  final String empId;
  final String empMail;
  final String empName;
  final String empPhotourl;
  final String empPwd;
  final List<dynamic> empShift;
  final List<dynamic> overtime;
  bool isSelected = false;

  factory EmployeeModel.fromRawJson(String str) =>
      EmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      attendance: List<Attendance>.from(
          json["attendance"].map((x) => Attendance.fromJson(x))),
      clientId: json["client_id"],
      clientLocation: json["client_location"],
      clientName: json["client_name"],
      clientSublocation: json["client_sublocation"],
      empId: json["emp_id"],
      empMail: json["emp_mail"],
      empName: json["emp_name"],
      empPhotourl: json["emp_photourl"],
      empPwd: json["emp_pwd"],
      empShift: List<dynamic>.from(json["emp_shift"].map((x) => x)),
      overtime: List<dynamic>.from(json["overtime"].map((x) => x)),
      isSelected: false);

  Map<String, dynamic> toJson() => {
        "attendance": List<dynamic>.from(attendance.map((x) => x.toJson())),
        "client_id": clientId,
        "client_location": clientLocation,
        "client_name": clientName,
        "client_sublocation": clientSublocation,
        "emp_id": empId,
        "emp_mail": empMail,
        "emp_name": empName,
        "emp_photourl": empPhotourl,
        "emp_pwd": empPwd,
        "emp_shift": List<dynamic>.from(empShift.map((x) => x)),
        "overtime": List<dynamic>.from(overtime.map((x) => x)),
      };
}

class Attendance {
  Attendance({
    this.checkIn,
    this.checkOut,
    this.date,
    this.shift,
    this.status,
  });

  final dynamic checkIn;
  final dynamic checkOut;
  final String? date;
  final String? shift;
  final dynamic status;

  factory Attendance.fromRawJson(String str) =>
      Attendance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        checkIn: json["checkIn"] ?? '',
        checkOut: json["checkOut"] ?? '',
        date: json["date"] ?? '',
        shift: json["shift"] ?? '',
        status: json["status"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "checkIn": checkIn,
        "checkOut": checkOut,
        "date": date,
        "shift": shift,
        "status": status,
      };
}
