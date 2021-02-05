import 'dart:convert';
import 'package:greetings_world_shopper/models/products/product_model.dart';
import 'package:greetings_world_shopper/models/user/user_model.dart';

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
     this.totalAmount,
    this.deliveryType,
    this.itemQuantity,
    this.product,
  });

  int id;
   int totalAmount;
  String deliveryType;
  int itemQuantity;
  ProductModel product;

  factory CartItem.fromJson(Map<String, dynamic> json)  {
    var item= CartItem(
      id: json["id"],
       itemQuantity: json["item_quantity"],
      product: ProductModel.fromJson(json["product"]),

    );
    item.totalAmount=item.itemQuantity*item.product.price;

    item.deliveryType=item.deliveryType!=null?item.deliveryType: item.product.deliver?"delivery":item.product.inStorePickup?"pickup":"delivery";




    return item;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
     "total_amount": totalAmount,
    "item_quantity": itemQuantity,
    "product": product.toJson(),
  };
}

 
