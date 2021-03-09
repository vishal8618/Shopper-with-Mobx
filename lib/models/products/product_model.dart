// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    this.productSku,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.good,
    this.likes,
    this.favorites,
  });

  int id;
  String name;
  int price;
  int merchantId;
  String productPhoto;
  String description;
  bool live;
  bool deliver;
  bool inStorePickup;
  dynamic productSku;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  Good good;
  Likes likes;
  Favorites favorites;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        merchantId: json["merchant_id"],
        productPhoto: json["product_photo"],
        description: json["description"],
        live: json["live"],
        deliver: json["deliver"],
        inStorePickup: json["in_store_pickup"],
        productSku: json["product_sku"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        url: json["url"],
        good: Good.fromJson(json["good"]),
        likes: json["likes"] == null ? null : Likes.fromJson(json["likes"]),
        favorites: json["favorites"] == null ? null : Favorites.fromJson(json["favorites"]),
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
        "product_sku": productSku,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "url": url,
        "good": good.toJson(),
        "likes": likes.toJson(),
        "favorites": favorites.toJson(),
      };
}

class Favorites {
  Favorites({
    this.id,
    this.productId,
    this.buyerId,
    this.isFavorite,
  });

  int id;
  int productId;
  int buyerId;
  bool isFavorite;

  factory Favorites.fromJson(Map<String, dynamic> json) => Favorites(
        id: json["id"],
        productId: json["product_id"],
        buyerId: json["buyer_id"],
        isFavorite: json["is_favorite"] == null ? null : json["is_favorite"] ,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "buyer_id": buyerId,
        "is_favorite": isFavorite,
      };
}

class Likes {
  Likes({
    this.id,
    this.productId,
    this.buyerId,
    this.isLiked,
  });

  int id;
  int productId;
  int buyerId;
  bool isLiked;

  factory Likes.fromJson(Map<String, dynamic> json) => Likes(
        id: json["id"],
        productId: json["product_id"],
        buyerId: json["buyer_id"],
        isLiked: json["is_liked"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "buyer_id": buyerId,
        "is_liked": isLiked,
      };
}

class Good {
  Good({
    this.id,
    this.productId,
    this.weight,
    this.height,
    this.length,
    this.width,
    this.createdAt,
    this.updatedAt,
    this.quantity,
    this.goodType,
  });

  int id;
  int productId;
  int weight;
  String height;
  String length;
  String width;
  DateTime createdAt;
  DateTime updatedAt;
  int quantity;
  String goodType;

  factory Good.fromJson(Map<String, dynamic> json) => Good(
        id: json["id"],
        productId: json["product_id"],
        weight: json["weight"],
        height: json["height"],
        length: json["length"],
        width: json["width"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        quantity: json["quantity"],
        goodType: json["good_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "weight": weight,
        "height": height,
        "length": length,
        "width": width,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "quantity": quantity,
        "good_type": goodType,
      };
}
