// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

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
    this.buyerPhoto,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.address,
  });

  int id;
  int userId;
  String firstName;
  String lastName;
  String email;
  String buyerPhoto;
  String phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  Address address;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    buyerPhoto: json["buyer_photo"],
    phoneNumber: json["phone_number"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    url: json["url"],
    address: Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "buyer_photo": buyerPhoto,
    "phone_number": phoneNumber,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "url": url,
    "address": address.toJson(),
  };
}

class Address {
  Address({
    this.city,
    this.street1,
    this.street2,
    this.countryName,
    this.stateName,
    this.zip,
    this.lat,
    this.lng,
  });

  String city;
  String street1;
  dynamic street2;
  String countryName;
  String stateName;
  String zip;
  dynamic lat;
  dynamic lng;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    street1: json["street1"],
    street2: json["street2"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    zip: json["zip"],
    lat: json["lat"],
    lng: json["lng"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "street1": street1,
    "street2": street2,
    "country_name": countryName,
    "state_name": stateName,
    "zip": zip,
    "lat": lat,
    "lng": lng,
  };
}
