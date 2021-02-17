// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.user,
    this.merchant,
    this.buyer,
    this.buyerAddress,
  });

  User user;
  dynamic merchant;
  Buyer buyer;
  BuyerAddress buyerAddress;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    user: User.fromJson(json["user"]),
    merchant: json["merchant"],
    buyer: Buyer.fromJson(json["buyer"]),
    buyerAddress: BuyerAddress.fromJson(json["buyer_address"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "merchant": merchant,
    "buyer": buyer.toJson(),
    "buyer_address": buyerAddress.toJson(),
  };
}

class Buyer {
  Buyer({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
    this.stripeId,
    this.token,
    this.deviceType,
    this.buyerPhoto,
  });

  int id;
  int userId;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  DateTime createdAt;
  DateTime updatedAt;
  String stripeId;
  dynamic token;
  dynamic deviceType;
  String buyerPhoto;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    stripeId: json["stripe_id"],
    token: json["token"],
    deviceType: json["device_type"],
    buyerPhoto: json["buyer_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone_number": phoneNumber,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "stripe_id": stripeId,
    "token": token,
    "device_type": deviceType,
    "buyer_photo": buyerPhoto,
  };
}

class BuyerAddress {
  BuyerAddress({
    this.id,
    this.name,
    this.city,
    this.street1,
    this.street2,
    this.countryName,
    this.stateName,
    this.phoneNumber,
    this.zip,
    this.lat,
    this.lng,
    this.addressableId,
    this.addressableType,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  dynamic name;
  String city;
  String street1;
  dynamic street2;
  String countryName;
  String stateName;
  dynamic phoneNumber;
  String zip;
  dynamic lat;
  dynamic lng;
  int addressableId;
  String addressableType;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory BuyerAddress.fromJson(Map<String, dynamic> json) => BuyerAddress(
    id: json["id"],
    name: json["name"],
    city: json["city"],
    street1: json["street1"],
    street2: json["street2"],
    countryName: json["country_name"],
    stateName: json["state_name"],
    phoneNumber: json["phone_number"],
    zip: json["zip"],
    lat: json["lat"],
    lng: json["lng"],
    addressableId: json["addressable_id"],
    addressableType: json["addressable_type"],
    deletedAt: json["deleted_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "city": city,
    "street1": street1,
    "street2": street2,
    "country_name": countryName,
    "state_name": stateName,
    "phone_number": phoneNumber,
    "zip": zip,
    "lat": lat,
    "lng": lng,
    "addressable_id": addressableId,
    "addressable_type": addressableType,
    "deleted_at": deletedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
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
  dynamic firstName;
  dynamic lastName;
  dynamic phoneNumber;
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
