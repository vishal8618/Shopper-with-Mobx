import 'dart:collection';
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/models/common/general_response.dart';
import 'package:greetings_world_shopper/models/confirmation/register_confirmation_model.dart';
import 'package:greetings_world_shopper/models/generate_otp/otp_model.dart';
import 'package:greetings_world_shopper/models/like/like_model.dart';
import 'package:greetings_world_shopper/models/user/login_model.dart';
import 'package:greetings_world_shopper/models/user/user_model.dart';

import '../../dio_client.dart';

class UserApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance

  // injecting dio instance
  UserApi(this._dioClient);

  /// register yourself
  Future<UserModel> signUp(
      {String fullName,
      String email,
      String password,
      String image,
      String phone,
      String deviceType}) async {
    try {
      var map = Map<String, dynamic>();
      map["first_name"] = fullName.contains(" ")
          ? fullName.substring(0, fullName.indexOf(" "))
          : fullName;

      map["last_name"] = fullName.contains(" ")
          ? fullName.substring(fullName.indexOf(" ") + 1, fullName.length)
          : "";

      if (image != null && image != "") map["buyer_photo"] = image;

      map["email"] = email;
      map["phone_number"] = phone;
      map["password"] = password;
      // map["deviceType"] = deviceType;

      final res =
          await _dioClient.post(Endpoints.signUp, data: map, options: null);
      return userModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // login in app
  Future<LoginModel> login({
    String email,
    String password,
  }) async {
    try {
      var map = Map<String, dynamic>();
      map["email"] = email;
      map["password"] = password;
      map["user_type"] = "buyer";

      final res = await _dioClient.post(Endpoints.login, data: map, options: null);
      // return loginModelFromJson(json.encode(res.data));
      return LoginModel.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Forgot Password
  Future<GeneralResponse> forgotPassword({
    String email,
  }) async {
    try {
      var map = Map<String, dynamic>();
      map["email"] = email;

      final res =
          await _dioClient.post(Endpoints.forgotPassword, data: map, options: null);
      return generalResponseFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // Reset Password
  Future<GeneralResponse> resetPassword({
    String email,
   String password,
    String confirmPassword
  }) async {
    try {
      var map = Map<String, dynamic>();
      map["token"] = email;
      map["password"] = password;
      map["password_confirmation"] = confirmPassword;

      final res =
          await _dioClient.post(Endpoints.resetPassword, data: map, options: null);
      return generalResponseFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // userDetail in app
  Future<UserModel> userDetail({String uid}) async {
    try {
      final res = await _dioClient.get("${Endpoints.userDetail}$uid.json",
          options: null);
      return userModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UserModel> updateProfileDetails(String uid,
      {String fullName, String image, String phone}) async {
    try {
      var map = Map<String, dynamic>();
      map["first_name"] = fullName.contains(" ")
          ? fullName.substring(0, fullName.indexOf(" "))
          : fullName;

      map["last_name"] = fullName.contains(" ")
          ? fullName.substring(fullName.indexOf(" ") + 1, fullName.length)
          : "";

      if (image != null && image != "") map["buyer_photo"] = image;

      map["phone_number"] = phone;
      final res = await _dioClient.put("${Endpoints.updateProfileDetail}$uid.json", data: map, options: null);
      return userModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UserModel> updateAddress(String uid,
      {String city,
      String street1,
      String street2,
      String countryName,
      String stateName,
      String zip,
      String lat,
      String lng}) async {
    try {
      var mainMap = Map<String, dynamic>();
      var map = Map<String, dynamic>();

       map["city"] = city;
      map["street1"] = street1;
      map["street2"] = street2;
      map["country_name"] = countryName;
      map["state_name"] = stateName;
      map["zip"] = zip;
      map["lat"] = lat;
      map["lng"] = lng;

      mainMap["address_attributes"]=map;


      final res = await _dioClient.put(
          "${Endpoints.updateProfileDetail}$uid.json",
          data: mainMap,
          options: null);
      return userModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  //Registration confirmation
  Future<RegisterConfirmationModel> confirmRegistration({String token}) async {
    try {
      final res = await _dioClient.get("${Endpoints.registrationConfirmation}",
          options: null,
      queryParameters: {
        "confirmation_token": token
      });
      return registerConfirmationModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  // generate otpCode
  Future<GenerateOtpModel> getGenerateOtp({String uid, String phoneNumber}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["phone_number"] = phoneNumber;
      final res = await _dioClient.get(Endpoints.generate_otp_code, queryParameters: map);
      return generateOtpModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }


  // phone_number_verify
  Future<GenerateOtpModel> phoneNumberVerify({String phoneNumber, String otp,String uid}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["phone_number"] = phoneNumber;
      map["authenticate_otp"] = otp;
      map["buyer_id"] = uid;
      final res = await _dioClient.get(Endpoints.phone_number_verify, queryParameters: map);
      return generateOtpModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
