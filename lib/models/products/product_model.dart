// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.id,
    this.name,
    this.price,
    this.merchantId,
    this.productPhoto,
    this.description,
    this.live,
    this.deliver,
    this.inStorePickup,
    this.createdAt,
    this.updatedAt,
    this.liked,
    this.url,
  });

  int id;
  bool liked ;
  String name;
  int price;
  int merchantId;
  String productPhoto;
  String description;
  bool live;
  bool deliver;
  bool inStorePickup;
  DateTime createdAt;
  DateTime updatedAt;
  String url;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    liked: json["likes"]!=null && json["likes"]['is_liked'],
    id: json["id"],
    name: json["name"],
    price: json["price"],
    merchantId: json["merchant_id"],
    productPhoto: json["product_photo"],
    description: json["description"],
    live: json["live"],
    deliver: json["deliver"],
    inStorePickup: json["in_store_pickup"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "merchant_id": merchantId,
    "product_photo": productPhoto,
    "description": description,
    "live": live,
    "deliver": deliver,
    "in_store_pickup": inStorePickup,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "url": url,
  };
}
