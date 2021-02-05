
import 'dart:convert';

List<MerchantModel> merchantsFromJson(String str) => List<MerchantModel>.from(json.decode(str).map((x) => MerchantModel.fromJson(x)));

String merchantsToJson(List<MerchantModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MerchantModel {
  MerchantModel({
    this.id,
    this.email,
    this.userId,
    this.logo,
    this.avatar,
    this.openAndClose,
    this.merchantPhoto,
    this.orderStoreEnabled,
    this.orderCurbsideEnabled,
    this.orderDeliveryEnabled,
    this.name,
    this.phoneNumber,
    this.tagline,
    this.address,
    this.ein,
    this.mtype,
    this.website,
    this.returnPolicy,
    this.createdAt,
    this.updatedAt,
    this.zip,
    this.city,
    this.state,
    this.acceptPrivacyPolicy,
    this.acceptReturnPolicy,
    this.url,
    this.phoneActivated,
    this.followers
  });

  int id;
  List<int> followers;
  String email;
  int userId;
  String logo;
  String avatar;
  String openAndClose;
  String merchantPhoto;
  bool orderStoreEnabled;
  bool orderCurbsideEnabled;
  bool orderDeliveryEnabled;
  String name;
  String phoneNumber;
  bool  phoneActivated;
  String tagline;
  String address;
  String ein;
  String mtype;
  String website;
  ReturnPolicy returnPolicy;
  DateTime createdAt;
  DateTime updatedAt;
  String zip;
  String city;
  String state;
  String acceptPrivacyPolicy;
  String acceptReturnPolicy;
  String url;

  factory MerchantModel.fromJson(Map<String, dynamic> json) => MerchantModel(
    id: json["id"],
    email: json["email"],
    followers: json["followers"] == null ? List() : List<int>.from(json["followers"].map((x) => x)),
    userId: json["user_id"],
    logo: json["logo"],
    avatar: json["avatar"],
    openAndClose: json["open_and_close"],
    merchantPhoto: json["merchant_photo"],
    phoneActivated: json["is_phone_number_visible"]==null?false:json["is_phone_number_visible"],
    orderStoreEnabled: json["order_store_enabled"],
    orderCurbsideEnabled: json["order_curbside_enabled"],
    orderDeliveryEnabled: json["order_delivery_enabled"],
    name: json["name"]==null?"":json["name"],
    phoneNumber: json["phone_number"],
    tagline: json["tagline"]==null?"":json["tagline"].trim(),
    address: json["address"],
    ein: json["ein"],
    mtype: json["mtype"],
    website: json["website"],
    returnPolicy: ReturnPolicy.fromJson(json["return_policy"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    zip: json["zip"],
    city: json["city"],
    state: json["state"],
    acceptPrivacyPolicy: json["accept_privacy_policy"],
    acceptReturnPolicy: json["accept_return_policy"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "user_id": userId,
    "logo": logo,
    "avatar": avatar,
    "open_and_close": openAndClose,
    "merchant_photo": merchantPhoto,
    "order_store_enabled": orderStoreEnabled,
    "order_curbside_enabled": orderCurbsideEnabled,
    "order_delivery_enabled": orderDeliveryEnabled,
    "name": name,
    "phone_number": phoneNumber,
    "tagline": tagline,
    "address": address,
    "is_phone_number_visible": phoneActivated,
    "ein": ein,
    "mtype": mtype,
    "website": website,
    "return_policy": returnPolicy.toJson(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "zip": zip,
    "city": city,
    "state": state,
    "accept_privacy_policy": acceptPrivacyPolicy,
    "accept_return_policy": acceptReturnPolicy,
    "url": url,
    "followers": followers == null ? null : List<dynamic>.from(followers.map((x) => x)),


  };
}

class ReturnPolicy {
  ReturnPolicy({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.day,
    this.name,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int day;
  String name;

  factory ReturnPolicy.fromJson(Map<String, dynamic> json) => ReturnPolicy(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    day: json["day"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "day": day,
    "name": name,
  };
}
