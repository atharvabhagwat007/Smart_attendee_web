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
    required this.overtime,
  });

  final List<Attendance> attendance;
  final String? clientId;
  final String? clientLocation;
  final String? clientName;
  final String? clientSublocation;
  final String empId;
  final String empMail;
  final String empName;
  final String empPhotourl;
  final String empPwd;
  final List<dynamic> overtime;
  bool isSelected = false;

  factory EmployeeModel.fromRawJson(String str) =>
      EmployeeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
      attendance: List<Attendance>.from(json["attendance"].map((x) {
        return Attendance.fromJson(Map<String, dynamic>.from(x));
      })),
      clientId: json["client_id"] as String?,
      clientLocation: json["client_location"] as String?,
      clientName: json["client_name"] as String?,
      clientSublocation: json["client_sublocation"] as String?,
      empId: json["emp_id"] as String,
      empMail: json["emp_mail"] as String,
      empName: json["emp_name"] as String,
      empPhotourl: json["emp_photourl"] as String,
      empPwd: json["emp_pwd"] as String,
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
        "overtime": List<dynamic>.from(overtime.map((x) => x)),
      };

  EmployeeModel copyWith(
      {List<Attendance>? attendance,
      String? clientId,
      String? clientLocation,
      String? clientName,
      String? clientSublocation,
      String? empId,
      String? empMail,
      String? empName,
      String? empPhotourl,
      String? empPwd,
      List<dynamic>? overtime,
      bool? isSelected}) {
    return EmployeeModel(
        attendance: attendance ?? this.attendance,
        clientId: clientId ?? this.clientId,
        clientLocation: clientLocation ?? this.clientLocation,
        clientName: clientName ?? this.clientName,
        clientSublocation: clientSublocation ?? this.clientSublocation,
        empId: empId ?? this.empId,
        empMail: empMail ?? this.empMail,
        empName: empName ?? this.empName,
        empPhotourl: empPhotourl ?? this.empPhotourl,
        empPwd: empPwd ?? this.empPwd,
        overtime: overtime ?? this.overtime,
        isSelected: isSelected ?? this.isSelected);
  }
}

class Attendance {
  Attendance(
      {this.checkIn,
      this.checkOut,
      this.date,
      this.shiftFrom,
      this.shiftTo,
      this.status,
      this.overTime});

  final dynamic checkIn;
  final dynamic checkOut;
  final String? date;
  final String? shiftFrom;
  final String? shiftTo;
  final dynamic status;
  final OverTime? overTime;

  factory Attendance.fromRawJson(String str) =>
      Attendance.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
      checkIn: json["checkIn"] ?? '',
      checkOut: json["checkOut"] ?? '',
      date: json["date"] ?? '',
      shiftFrom: json["shiftFrom"] ?? '',
      shiftTo: json["shiftTo"] ?? '',
      status: json["status"] ?? '',
      overTime: json["overtime"] != null
          ? OverTime.fromJson(json["overtime"])
          : null);

  Map<String, dynamic> toJson() => {
        "checkIn": checkIn,
        "checkOut": checkOut,
        "date": date,
        "shiftFrom": shiftFrom,
        "shiftTo":shiftTo,
        "status": status,
        "overtime": overTime?.toJson()
      };
}

class OverTime {
  final int duration;
  final String status;
  OverTime({required this.duration, required this.status});

  factory OverTime.fromRawJson(String str) =>
      OverTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OverTime.fromJson(Map<String, dynamic> json) =>
      OverTime(duration: json['duration'], status: json['status']);

  Map<String, dynamic> toJson() => {"duration": duration, "status": status};
}

class EmployeeShift {
  EmployeeShift(
      {required this.date, required this.shiftFrom, required this.shiftTo});

  final String date;
  final String shiftFrom;
  final String shiftTo;

  factory EmployeeShift.fromRawJson(String str) =>
      EmployeeShift.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeShift.fromJson(Map<String, String?> json) => EmployeeShift(
      date: json["date"] ?? '',
      shiftFrom: json["shiftFrom"] ?? '',
      shiftTo: json["shiftTo"] ?? '');

  Map<String, String> toJson() => {
        "date": date,
        "shiftFrom": shiftFrom,
        "shiftTo": shiftTo,
      };
}
