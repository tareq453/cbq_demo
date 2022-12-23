import 'country.dart';

class User {
  final String? id;
  final String? mobileNumber;
  final Country? country;

  User({required this.id, required this.mobileNumber, required this.country});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "mobileNumber": mobileNumber,
      "country": country?.toJson()
    };
  }

  factory User.fromJson(dynamic json) {
    return User(
        id: json['id'],
        mobileNumber: json['mobileNumber'],
        country: Country.fromJson(json['country']));
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
