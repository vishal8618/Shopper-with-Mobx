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
     this.createdAt,
    this.updatedAt,
    this.city,
    this.state,
    this.address,
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
  Address address;


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
         createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        url: json["url"],
    address: Address.fromJson(json["address"]),


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
         "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "city": city,
        "state": state,
        "zip": zip,
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

