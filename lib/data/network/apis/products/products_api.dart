import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
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
  Future<List<ProductModel>> getProducts({String id}) async {
    try {
      final res = await _dioClient
          .get("${Endpoints.getProducts}$id${Endpoints.products}");
      return productFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> addWish({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["product_id"] = productId;
      map["is_liked"] = true;

      final res = await _dioClient.post(Endpoints.addWish, data: map);
      // return productFromJson(json.encode(res.data));
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> removeWish({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["product_id"] = productId;
      map["is_liked"] = false;
      final res = await _dioClient.delete(Endpoints.removeWish, data: map);
      // return productFromJson(json.encode(res.data));
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
