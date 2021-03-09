// To parse this JSON data, do
//
//     final cartItemModel = cartItemModelFromJson(jsonString);

import 'dart:convert';

List<CartItemModel> cartItemModelFromJson(String str) => List<CartItemModel>.from(json.decode(str).map((x) => CartItemModel.fromJson(x)));

String cartItemModelToJson(List<CartItemModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartItemModel {
  CartItemModel({
    this.cartItem,
    this.url,
  });

  CartItem cartItem;
  String url;

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
    cartItem: CartItem.fromJson(json["cart_item"]),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "cart_item": cartItem.toJson(),
    "url": url,
  };
}

class CartItem {
  CartItem({
    this.id,
    this.buyerId,
    this.subTotal,
    this.itemQuantity,
    this.product,
    this.deliveryType,
    this.shippingAmount,
    this.shipmentId,
    this.taxCharges,
    this.deliveryEstimatedDays,
  });

  int id;
  int buyerId;
  int subTotal;
  int itemQuantity;
  Product product;
  dynamic deliveryType;
  double shippingAmount;
  String shipmentId;
  double taxCharges;
  String deliveryEstimatedDays;

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json["id"]== null ? null :json["id"],
    buyerId: json["buyer_id"]== null ? null : json["buyer_id"],
    subTotal: json["sub_total"]== null ? null : json["sub_total"],
    itemQuantity: json["item_quantity"]== null ? null : json["item_quantity"],
    product: Product.fromJson(json["product"]),
    deliveryType: json["delivery_type"]== null ? null : json["delivery_type"],
    shippingAmount: json["shipping_amount"] == null ? 0.0 : json["shipping_amount"],
    shipmentId: json["shipment_id"]== null ? null : json["shipment_id"],
    taxCharges: json["tax_charges"]== null ? 0.0 : json["tax_charges"],
    deliveryEstimatedDays: json["delivery_estimated_days"]== null ? null : json["delivery_estimated_days"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "buyer_id": buyerId,
    "sub_total": subTotal,
    "item_quantity": itemQuantity,
    "product": product.toJson(),
    "delivery_type": deliveryType,
    "shipping_amount": shippingAmount,
    "shipment_id": shipmentId,
    "tax_charges": taxCharges,
    "delivery_estimated_days": deliveryEstimatedDays,
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.merchantId,
    this.description,
    this.live,
    this.createdAt,
    this.updatedAt,
    this.productPhoto,
    this.deliver,
    this.inStorePickup,
    this.productSku,
  });

  int id;
  String name;
  int price;
  int merchantId;
  String description;
  bool live;
  DateTime createdAt;
  DateTime updatedAt;
  String productPhoto;
  bool deliver;
  bool inStorePickup;
  dynamic productSku;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    merchantId: json["merchant_id"],
    description: json["description"],
    live: json["live"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    productPhoto: json["product_photo"],
    deliver: json["deliver"],
    inStorePickup: json["in_store_pickup"],
    productSku: json["product_sku"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "merchant_id": merchantId,
    "description": description,
    "live": live,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "product_photo": productPhoto,
    "deliver": deliver,
    "in_store_pickup": inStorePickup,
    "product_sku": productSku,
  };
}
