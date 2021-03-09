import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:greetings_world_shopper/data/network/constants/endpoints.dart';
import 'package:greetings_world_shopper/models/cart/cart_item_model.dart';
import 'package:greetings_world_shopper/models/cart/update_cart_model.dart';
import 'package:greetings_world_shopper/models/merchants/merchant_model.dart';
import 'package:greetings_world_shopper/models/orders/create_order_model.dart';
import 'package:greetings_world_shopper/models/products/product_model.dart';

import '../../dio_client.dart';

class CartApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CartApi(this._dioClient);

  Future<UpdateCartModel> addCart({String uid, String productId}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = int.parse(uid);
      map["product_id"] = int.parse(productId);

      final res = await _dioClient.post(Endpoints.addCart, data: map);
      return updateCartModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<UpdateCartModel> removeCart(
      {String uid, String productId, String quantity}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = int.parse(uid);
      map["product_id"] = int.parse(productId);

      // to delete item
      if (quantity != null) map["item_quantity"] = int.parse(quantity);

      final res = await _dioClient.delete(Endpoints.removeCart, data: map);
      return updateCartModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<CartItemModel>> getCart({String uid}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;

      final res =
          await _dioClient.get(Endpoints.cartList, queryParameters: map);
      return cartItemModelFromJson(json.encode(res.data));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<OrdersModel> createOrder(
      {String uid,
      String totalAmount,
      String subTotal,
      String shippingAmount,
      String taxCharges,
      String serviceCharges,
      String stripeToken}) async {
    try {
      var map = HashMap<String, dynamic>();
      map["buyer_id"] = uid;
      map["total_amount"] = totalAmount;
      map["sub_total"] = subTotal;
      map["shipping_amount"] = shippingAmount;
      map["tax_charges"] = taxCharges;
      map["service_charges"] = serviceCharges;
      map["stripe_token"] = stripeToken;

      final res = await _dioClient.post(Endpoints.createOrder, data: map);
      return ordersModelFromJson(json.encode(res.data));

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
