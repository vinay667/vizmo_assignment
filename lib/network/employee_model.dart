import 'dart:convert';

class EmployeeResponseModel {
  final List<Data> list;

  EmployeeResponseModel({required this.list});

  factory EmployeeResponseModel.fromJson(List<dynamic> parsedJson) {
    List<Data> employees;
    employees = parsedJson.map((i) => Data.fromJson(i)).toList();

    return EmployeeResponseModel(list: employees);
  }
}

class Data {
  Data({
    required this.name,
    required this.avatar,
    required this.email,
    required this.phone,
    required this.country,
    required this.id,
  });

  String name;
  String avatar;
  String email;
  String phone;
  String country;
  String id;

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
        name: parsedJson['name'],
        email: parsedJson['email'],
        phone: parsedJson['phone'],
        country: parsedJson['country'],
        id: parsedJson['id'],
        avatar: parsedJson['avatar']);
  }
}
