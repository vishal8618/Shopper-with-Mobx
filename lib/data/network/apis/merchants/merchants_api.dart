import 'dart:async';
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
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
  Future<String> followMerchant({String uid, String merchantId}) async {
    try {
      var data = Map<String, dynamic>();
      data["buyer_id"] = uid;
      data["merchant_id"] = merchantId;

      final res = await _dioClient.post(Endpoints.followMerchant, data: data);
      return res.data.toString();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  // follow merchant
  Future<String> unFollowMerchant({String uid, String merchantId}) async {
    try {
      var data = Map<String, dynamic>();
      data["buyer_id"] = uid;
      data["merchant_id"] = merchantId;

      final res = await _dioClient.post(Endpoints.unFollowMerchant, data: data);
      return res.data.toString();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
