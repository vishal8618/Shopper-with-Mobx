// To parse this JSON data, do
//
//     final updateCartModel = updateCartModelFromJson(jsonString);

import 'dart:convert';

UpdateCartModel updateCartModelFromJson(String str) => UpdateCartModel.fromJson(json.decode(str));

String updateCartModelToJson(UpdateCartModel data) => json.encode(data.toJson());

class UpdateCartModel {
  UpdateCartModel({
    this.message,
    this.itemCount,
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
