import 'dart:convert';

class Client {
  Client(
      {required this.id,
      required this.location,
      required this.subLocation,
      required this.name,
      required this.employees,
      required this.pastEmployees,
      required this.currentEmployeeAssignTime});

  final String id;
  final String location;
  final String subLocation;
  final String name;
  final List<String> employees;
  final List<PastEmployee> pastEmployees;
  final String currentEmployeeAssignTime;

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
      id: json["client_id"] as String,
      name: json["client_name"] as String,
      location: json["client_location"] as String,
      subLocation: json["client_sublocation"] as String,
      employees:
          (json["employees"] as List<dynamic>?)?.cast<String>() ?? <String>[],
      currentEmployeeAssignTime: json["timestamp"] as String? ?? '',
      pastEmployees: (json["past_emp"] as List<dynamic>?)
              ?.map((e) => PastEmployee.fromJson(e))
              .toList() ??
          <PastEmployee>[]);

  Map<String, dynamic> toJson() => {
        "client_id": id,
        "client_name": name,
        "client_location": location,
        "client_sublocation": subLocation,
        "employees": employees,
        "timestamp": currentEmployeeAssignTime,
        "past_emp": pastEmployees
      };

  Client copyWith(
      {String? id,
      String? location,
      String? subLocation,
      String? name,
      List<String>? employees,
      List<PastEmployee>? pastEmployees,
      String? currentEmployeeAssignTime}) {
    return Client(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
        subLocation: subLocation ?? this.subLocation,
        employees: employees ?? this.employees,
        currentEmployeeAssignTime:
            currentEmployeeAssignTime ?? this.currentEmployeeAssignTime,
        pastEmployees: pastEmployees ?? this.pastEmployees);
  }
}

class PastEmployee {
  PastEmployee({required this.timeStamp, required this.employees});

  final List<String> employees;
  final String timeStamp;

  factory PastEmployee.fromRawJson(String str) =>
      PastEmployee.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PastEmployee.fromJson(Map<String, dynamic> json) => PastEmployee(
      timeStamp: json["timeStamp"] as String? ?? '',
      employees:
          (json["employees"] as List<dynamic>?)?.cast<String>() ?? <String>[]);

  Map<String, dynamic> toJson() =>
      {"timeStamp": timeStamp, "employees": employees};

  PastEmployee copyWith({List<String>? employees, String? timeStamp}) {
    return PastEmployee(
        employees: employees ?? this.employees,
        timeStamp: timeStamp ?? this.timeStamp);
  }
}
