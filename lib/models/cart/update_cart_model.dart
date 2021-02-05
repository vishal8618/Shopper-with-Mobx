// To parse this JSON data, do
//
//     final updateCart = updateCartFromJson(jsonString);

import 'dart:convert';

UpdateCartModel updateCartFromJson(String str) => UpdateCartModel.fromJson(json.decode(str));

String updateCartToJson(UpdateCartModel data) => json.encode(data.toJson());

class UpdateCartModel {
  UpdateCartModel({
    this.message,
    this.itemCount
  });

  String message;
  int itemCount;

  factory UpdateCartModel.fromJson(Map<String, dynamic> json) => UpdateCartModel(
    message: json["message"],
    itemCount: json["item_count"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "item_count": itemCount,
  };
}
