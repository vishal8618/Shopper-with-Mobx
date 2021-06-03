// To parse this JSON data, do
//
//     final generalResponse = generalResponseFromJson(jsonString);

import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) => GeneralResponse.fromJson(json.decode(str));

String generalResponseToJson(GeneralResponse data) => json.encode(data.toJson());

class GeneralResponse {
  GeneralResponse({
    this.message,
    this.status,
  });

  final String message;
  final bool status;

  GeneralResponse copyWith({
    String message,
    bool status,
  }) =>
      GeneralResponse(
        message: message ?? this.message,
        status: status ?? this.status,
      );

  factory GeneralResponse.fromJson(Map<String, dynamic> json) => GeneralResponse(
    message: json["message"] == null ? null : json["message"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "status": status == null ? null : status,
  };
}
