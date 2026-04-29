// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

/*class LoginModel {
  LoginModel({
    this.confirmedUser,
    this.user,
    this.merchant,
    this.buyer,
    this.buyerAddress,
  });

  bool confirmedUser;
  User user;
  dynamic merchant;
  Buyer buyer;
  BuyerAddress buyerAddress;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    confirmedUser: json["confirmed_user"],
    user: User.fromJson(json["user"]),
    merchant: json["merchant"],
    buyer: Buyer.fromJson(json["buyer"]),
    buyerAddress: BuyerAddress.fromJson(json["buyer_address"]),
  );

  Map<String, dynamic> toJson() => {
    "confirmed_user": confirmedUser,
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
  dynamic stripeId;
  dynamic token;
  dynamic deviceType;
  dynamic buyerPhoto;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    stripeId: json["stripe_id"],
    token: json["token"],
    deviceType: json["device_type"],
    buyerPhoto: json["buyer_photo"] == null ? "" : json["buyer_photo"],
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

  dynamic id;
  dynamic name;
  dynamic city;
  dynamic street1;
  dynamic street2;
  dynamic countryName;
  dynamic stateName;
  dynamic phoneNumber;
  dynamic zip;
  dynamic lat;
  dynamic lng;
  dynamic addressableId;
  dynamic addressableType;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
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
}*/

class LoginModel {
  bool confirmedUser;
  bool phoneNumberVerified;
  User user;
  Merchant merchant;
  Buyer buyer;
  BuyerAddress buyerAddress;

  LoginModel(
      {this.confirmedUser,
      this.phoneNumberVerified,
      this.user,
      this.merchant,
      this.buyer,
      this.buyerAddress});

  LoginModel.fromJson(Map<String, dynamic> json) {
    confirmedUser = json['confirmed_user'];
    phoneNumberVerified = json['phone_number_verified'];
    if (json['user'] != null) {
      user = new User.fromJson(json['user']);
    }

    if (json['merchant'] != null) {
      merchant = new Merchant.fromJson(json['merchant']);
    }

    if(json['buyer'] != null){
      buyer =  Buyer.fromJson(json["buyer"]);
    }

    if(json['buyer_address'] != null){
      buyerAddress = new BuyerAddress.fromJson(json['buyer_address']);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirmed_user'] = this.confirmedUser;
    data['phone_number_verified'] = this.phoneNumberVerified;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.merchant != null) {
      data['merchant'] = this.merchant.toJson();
    }
    if (this.buyer != null) {
      data['buyer'] = this.buyer.toJson();
    }

    if (this.buyerAddress != null) {
      data['buyer_address'] = this.buyerAddress.toJson();
    }
    return data;
  }
}

class User {
  bool emailConfirmed;
  bool phoneConfirmed;
  String token;
  int id;
  String email;
  String createdAt;
  String updatedAt;
  String firstName;
  String lastName;
  dynamic phoneNumber;
  bool admin;
  dynamic authenticateOtp;
  dynamic otpSentAt;
  bool isBuyer;

  User(
      {this.emailConfirmed,
      this.phoneConfirmed,
      this.token,
      this.id,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.admin,
      this.authenticateOtp,
      this.otpSentAt,
      this.isBuyer});

  User.fromJson(Map<String, dynamic> json) {
    emailConfirmed = json['email_confirmed'];
    phoneConfirmed = json['phone_confirmed'];
    token = json['token'];
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phoneNumber = json['phone_number'];
    admin = json['admin'];
    authenticateOtp = json['authenticate_otp'];
    otpSentAt = json['otp_sent_at'];
    isBuyer = json['is_buyer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_confirmed'] = this.emailConfirmed;
    data['phone_confirmed'] = this.phoneConfirmed;
    data['token'] = this.token;
    data['id'] = this.id;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['phone_number'] = this.phoneNumber;
    data['admin'] = this.admin;
    data['authenticate_otp'] = this.authenticateOtp;
    data['otp_sent_at'] = this.otpSentAt;
    data['is_buyer'] = this.isBuyer;
    return data;
  }
}

class Merchant {
  int id;
  int userId;
  String name;
  String phoneNumber;
  String tagline;
  String address;
  String ein;
  int returnPolicyId;
  String openAndClose;
  String website;
  String createdAt;
  String updatedAt;
  dynamic stripeId;
  String merchantPhoto;
  String logo;
  String mtype;
  dynamic specialCode;
  dynamic avatar;
  String email;
  String city;
  String state;
  String zip;
  bool orderStoreEnabled;
  bool orderCurbsideEnabled;
  bool orderDeliveryEnabled;
  dynamic token;
  dynamic deviceType;
  bool isPhoneNumberVisible;

  Merchant(
      {this.id,
      this.userId,
      this.name,
      this.phoneNumber,
      this.tagline,
      this.address,
      this.ein,
      this.returnPolicyId,
      this.openAndClose,
      this.website,
      this.createdAt,
      this.updatedAt,
      this.stripeId,
      this.merchantPhoto,
      this.logo,
      this.mtype,
      this.specialCode,
      this.avatar,
      this.email,
      this.city,
      this.state,
      this.zip,
      this.orderStoreEnabled,
      this.orderCurbsideEnabled,
      this.orderDeliveryEnabled,
      this.token,
      this.deviceType,
      this.isPhoneNumberVisible});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    tagline = json['tagline'];
    address = json['address'];
    ein = json['ein'];
    returnPolicyId = json['return_policy_id'];
    openAndClose = json['open_and_close'];
    website = json['website'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    stripeId = json['stripe_id'];
    merchantPhoto = json['merchant_photo'];
    logo = json['logo'];
    mtype = json['mtype'];
    specialCode = json['special_code'];
    avatar = json['avatar'];
    email = json['email'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    orderStoreEnabled = json['order_store_enabled'];
    orderCurbsideEnabled = json['order_curbside_enabled'];
    orderDeliveryEnabled = json['order_delivery_enabled'];
    token = json['token'];
    deviceType = json['device_type'];
    isPhoneNumberVisible = json['is_phone_number_visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['tagline'] = this.tagline;
    data['address'] = this.address;
    data['ein'] = this.ein;
    data['return_policy_id'] = this.returnPolicyId;
    data['open_and_close'] = this.openAndClose;
    data['website'] = this.website;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['stripe_id'] = this.stripeId;
    data['merchant_photo'] = this.merchantPhoto;
    data['logo'] = this.logo;
    data['mtype'] = this.mtype;
    data['special_code'] = this.specialCode;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip'] = this.zip;
    data['order_store_enabled'] = this.orderStoreEnabled;
    data['order_curbside_enabled'] = this.orderCurbsideEnabled;
    data['order_delivery_enabled'] = this.orderDeliveryEnabled;
    data['token'] = this.token;
    data['device_type'] = this.deviceType;
    data['is_phone_number_visible'] = this.isPhoneNumberVisible;
    return data;
  }
}

class BuyerAddress {
  dynamic id;
  dynamic name;
  dynamic city;
  dynamic street1;
  dynamic street2;
  dynamic countryName;
  dynamic stateName;
  dynamic phoneNumber;
  dynamic zip;
  dynamic lat;
  dynamic lng;
  dynamic addressableId;
  dynamic addressableType;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  BuyerAddress(
      {this.id,
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
      this.updatedAt});

  BuyerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    street1 = json['street1'];
    street2 = json['street2'];
    countryName = json['country_name'];
    stateName = json['state_name'];
    phoneNumber = json['phone_number'];
    zip = json['zip'];
    lat = json['lat'];
    lng = json['lng'];
    addressableId = json['addressable_id'];
    addressableType = json['addressable_type'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['city'] = this.city;
    data['street1'] = this.street1;
    data['street2'] = this.street2;
    data['country_name'] = this.countryName;
    data['state_name'] = this.stateName;
    data['phone_number'] = this.phoneNumber;
    data['zip'] = this.zip;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['addressable_id'] = this.addressableId;
    data['addressable_type'] = this.addressableType;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
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
  dynamic stripeId;
  dynamic token;
  dynamic deviceType;
  dynamic buyerPhoto;

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        stripeId: json["stripe_id"],
        token: json["token"],
        deviceType: json["device_type"],
        buyerPhoto: json["buyer_photo"] == null ? "" : json["buyer_photo"],
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
