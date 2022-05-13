class DetailModel {
  DetailModel({
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

  factory DetailModel.fromJson(Map<String, dynamic> parsedJson) {
    return DetailModel(
        name: parsedJson['name'],
        email: parsedJson['email'],
        phone: parsedJson['phone'],
        country: parsedJson['country'],
        id: parsedJson['id'],
        avatar: parsedJson['avatar']);
  }
}
