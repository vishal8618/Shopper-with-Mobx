import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.buyerPhoto,
    this.address,
    this.createdAt,
    this.updatedAt,
    this.city,
    this.state,
    this.zip,
    this.error,
    this.url,
  });

  int id;
  int userId;
  String firstName;
  String error;
  String lastName;
  String email;
  String phoneNumber;
  String buyerPhoto;
  dynamic address;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic city;
  dynamic state;
  dynamic zip;
  String url;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        error: json["error"],
        phoneNumber: json["phone_number"],
        buyerPhoto: json["buyer_photo"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "error": error,
        "phone_number": phoneNumber,
        "buyer_photo": buyerPhoto,
        "address": address,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "city": city,
        "state": state,
        "zip": zip,
        "url": url,
      };
}
