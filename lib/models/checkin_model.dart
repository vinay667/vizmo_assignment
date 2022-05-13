import 'dart:convert';

class CheckInResponseModel {
  final List<EmployeeCheckIN> list;

  CheckInResponseModel({required this.list});

  factory CheckInResponseModel.fromJson(List<dynamic> parsedJson) {
    List<EmployeeCheckIN> employees;
    employees = parsedJson.map((i) => EmployeeCheckIN.fromJson(i)).toList();

    return CheckInResponseModel(list: employees);
  }
}

class EmployeeCheckIN {
  EmployeeCheckIN({
    required this.checkin,
    required this.location,
    required this.purpose,
    required this.employeeId,
    required this.id,
  });

  String checkin;
  String location;
  String purpose;
  String employeeId;
  String id;

  factory EmployeeCheckIN.fromJson(Map<String, dynamic> parsedJson) {
    return EmployeeCheckIN(
        checkin: parsedJson['checkin'],
        location: parsedJson['location'],
        purpose: parsedJson['purpose'],
        employeeId: parsedJson['employeeId'],
        id: parsedJson['id']);
  }
}
