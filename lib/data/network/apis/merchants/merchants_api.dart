import 'dart:async';
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/models/merchnat_follow_model/merchant_follow_order.dart';
import 'package:greetings_world_shopper/models/report/report_model.dart';
import '../../dio_client.dart';

class MerchantsApi {
  // dio instance
  final DioClient _dioClient;




  // injecting dio instance
  MerchantsApi(this._dioClient);

  /// Returns list of post in response
  Future<List<MerchantModel>> getMerchants(
      {String search, String tab, int limit, int offset}) async {
    try {
      var queryParameters = Map<String, dynamic>();
      if (tab != null) queryParameters["mtype"] = tab;
      if (search != null) queryParameters["search"] = search;
      if(search==null) {
        queryParameters["limit"] = limit;
        queryParameters["offset"] = offset;
      }

      final res = await _dioClient.get(Endpoints.getMerchants,
          queryParameters: queryParameters);
      return merchantsFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // follow merchant
  Future<FollowModel> followMerchant({String uid, String merchantId}) async {
    try {
      var data = Map<String, dynamic>();
      data["buyer_id"] = uid;
      data["merchant_id"] = merchantId;

      final res = await _dioClient.post(Endpoints.followMerchant, data: data);
      return followModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // follow merchant
  Future<FollowModel> unFollowMerchant({String uid, String merchantId}) async {
    try {
      var data = Map<String, dynamic>();
      data["buyer_id"] = uid;
      data["merchant_id"] = merchantId;

      final res = await _dioClient.post(Endpoints.unFollowMerchant, data: data);
      return followModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<ReportModel> addProductReport({
    String uid,
    String productId,
    String reason
  }) async {
    try {
      var data = Map<String, dynamic>();
      data["buyer_id"] = uid;
      data["product_id"] = productId;
      data["reason"] = reason;

      final res =
      await _dioClient.post(Endpoints.addReport, data: data, options: null);
      return reportModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ReportModel> addMerchantReport({
    String uid,
    String merchantId,
    String reason
  }) async {
    try {
      var data = Map<String, dynamic>();
      data["buyer_id"] = uid;
      data["merchant_id"] = merchantId;
      data["reason"] = reason;

      final res =
      await _dioClient.post(Endpoints.addMerchantReport, data: data, options: null);
      return reportModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }



}
