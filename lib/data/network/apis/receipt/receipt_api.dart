
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/models/like/like_model.dart';
import 'package:greetings_world_shopper/models/receipt/receipt_model.dart';
import 'package:greetings_world_shopper/models/receipt_detail/receipt_detail_model.dart';

import '../../dio_client.dart';

class ReceiptApi {

  // dio instance
  final DioClient _dioClient;




  // injecting dio instance
  ReceiptApi(this._dioClient);


  /// Returns list of post in response
  Future<List<ReceiptModel>> getReceipt(
      { String uid,int limit, int offset}) async {
    try {
      var queryParameters = Map<String, dynamic>();

      final res = await _dioClient.get("${Endpoints.getReceipt}.json?buyer_id=$uid",
          queryParameters: queryParameters);
      return receiptModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Returns list of post in response
  Future<ReceiptDetailModel> getReceiptDetail({String id,String uid}) async {
    try {
      final res = await _dioClient.get("${Endpoints.getReceiptDetail}$id.json?buyer_id=$uid");
      return receiptDetailModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }



  Future<LikeModel> cancelOrder(String orderId,
      {String uid}) async {
    try {
      var map = Map<String, dynamic>();
      map["buyer_id"] = uid;
      final res = await _dioClient.put("${Endpoints.cancelOrder}$orderId.json", data: map, options: null);
      return likeModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }



}