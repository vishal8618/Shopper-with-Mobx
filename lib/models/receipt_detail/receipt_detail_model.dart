// To parse this JSON data, do
//
//     final receiptDetailModel = receiptDetailModelFromJson(jsonString);

import 'dart:convert';

ReceiptDetailModel receiptDetailModelFromJson(String str) => ReceiptDetailModel.fromJson(json.decode(str));

String receiptDetailModelToJson(ReceiptDetailModel data) => json.encode(data.toJson());

class ReceiptDetailModel {
  ReceiptDetailModel({
    this.id,
    this.merchantId,
    this.buyerId,
    this.totalAmount,
    this.subTotal,
    this.deliveryType,
    this.status,
    this.paymentId,
    this.transactionId,
    this.shippingAmount,
    this.trackingNumber,
    this.trackingUrl,
    this.trackingStatus,
    this.taxCharges,
    this.serviceCharges,
    this.deliveryEstimatedDays,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.pdfUrl,
    this.orderItems,
    this.address
  });

  int id;
  int merchantId;
  int buyerId;
  double totalAmount;
  double subTotal;
  dynamic deliveryType;
  String status;
  dynamic paymentId;
  String transactionId;
  double shippingAmount;
  String trackingNumber;
  String trackingUrl;
  String trackingStatus;
  double taxCharges;
  dynamic serviceCharges;
  String deliveryEstimatedDays;
  DateTime createdAt;
  DateTime updatedAt;
  String url;
  String pdfUrl;
  OrderItems orderItems;
  dynamic address;

  factory ReceiptDetailModel.fromJson(Map<String, dynamic> json) => ReceiptDetailModel(
    id: json["id"],
    merchantId: json["merchant_id"],
    buyerId: json["buyer_id"],
    totalAmount: json["total_amount"],
    subTotal: json["sub_total"],
    deliveryType: json["delivery_type"],
    status: json["status"],
    paymentId: json["payment_id"],
    transactionId: json["transaction_id"],
    shippingAmount: json["shipping_amount"],
    trackingNumber: json["tracking_number"],
    trackingUrl: json["tracking_url"],
    trackingStatus: json["tracking_status"],
    taxCharges: json["tax_charges"],
    serviceCharges: json["service_charges"],
    deliveryEstimatedDays: json["delivery_estimated_days"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    url: json["url"],
    pdfUrl: json["pdf_url"],
    orderItems: OrderItems.fromJson(json["order_items"]),
    address: json.containsKey("address") ? json["address"] : ""
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "merchant_id": merchantId,
    "buyer_id": buyerId,
    "total_amount": totalAmount,
    "sub_total": subTotal,
    "delivery_type": deliveryType,
    "status": status,
    "payment_id": paymentId,
    "transaction_id": transactionId,
    "shipping_amount": shippingAmount,
    "tracking_number": trackingNumber,
    "tracking_url": trackingUrl,
    "tracking_status": trackingStatus,
    "tax_charges": taxCharges,
    "service_charges": serviceCharges,
    "delivery_estimated_days": deliveryEstimatedDays,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "url": url,
    "pdf_url": pdfUrl,
    "order_items": orderItems.toJson(),
    "address" : address
  };
}

class OrderItems {
  OrderItems({
    this.id,
    this.orderId,
    this.buyer,
    this.itemQuantity,
    this.product,
    this.productPrice,
    this.productPhoto,
  });

  int id;
  int orderId;
  String buyer;
  int itemQuantity;
  String product;
  int productPrice;
  String productPhoto;

  factory OrderItems.fromJson(Map<String, dynamic> json) => OrderItems(
    id: json["id"],
    orderId: json["order_id"],
    buyer: json["buyer"],
    itemQuantity: json["item_quantity"],
    product: json["product"],
    productPrice: json["product_price"],
    productPhoto: json["product_photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "buyer": buyer,
    "item_quantity": itemQuantity,
    "product": product,
    "product_price": productPrice,
    "product_photo": productPhoto,
  };
}
