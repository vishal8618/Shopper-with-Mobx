
// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:greetings_world_shopper/models/user/user_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.user,
    this.merchant,
    this.buyer,
  });

  User user;
  dynamic merchant;
  UserModel buyer;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    user: User.fromJson(json["user"]),
    merchant: json["merchant"],
    buyer: UserModel.fromJson(json["buyer"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "merchant": merchant,
    "buyer": buyer.toJson(),
  };
}



class User {
  User({
    this.token,
    this.id,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.admin,
  });

  String token;
  int id;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String firstName;
  String lastName;
  String phoneNumber;
  bool admin;

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
    id: json["id"],
    email: json["email"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    firstName: json["first_name"],
    lastName: json["last_name"],
    phoneNumber: json["phone_number"],
    admin: json["admin"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "email": email,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "first_name": firstName,
    "last_name": lastName,
    "phone_number": phoneNumber,
    "admin": admin,
  };
}

