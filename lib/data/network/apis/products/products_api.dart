import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/models/like/like_model.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/models/products/product_model.dart';
import '../../dio_client.dart';

class ProductsApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance

  // injecting dio instance
  ProductsApi(this._dioClient   );

  /// Returns list of post in response
  Future<List<ProductModel>> getProducts({String id,String uid}) async {
    try {
      final res = await _dioClient.get("${Endpoints.getProducts}$id/products.json?buyer_id=$uid");
      return productModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LikeModel> addWish({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["product_id"] = productId;
      map["is_liked"] = true;

      final res = await _dioClient.post(Endpoints.addWish, data: map);
       return likeModelFromJson(json.encode(res.data));
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LikeModel> removeWish({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["product_id"] = productId;
      map["is_liked"] = false;
      final res = await _dioClient.delete(Endpoints.removeWish, data: map);
      return likeModelFromJson(json.encode(res.data));
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LikeModel> addFavourite({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["product_id"] = productId;
      map["is_favorite"] = true;

      final res = await _dioClient.post(Endpoints.addFavourite, data: map);
      return likeModelFromJson(json.encode(res.data));
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LikeModel> removeFavourite({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["product_id"] = productId;
      map["is_favorite"] = false;
      final res = await _dioClient.delete(Endpoints.removeFavourite, data: map);
      return likeModelFromJson(json.encode(res.data));
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
