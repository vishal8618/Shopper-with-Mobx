import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
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
      String phone}) async {
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

      final res =
          await _dioClient.post(Endpoints.login, data: map, options: null);
      return loginModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // login in app
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
}
