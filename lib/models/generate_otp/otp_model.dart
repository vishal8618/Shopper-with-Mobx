// To parse this JSON data, do
//
//     final generateOtpModel = generateOtpModelFromJson(jsonString);

import 'dart:convert';

GenerateOtpModel generateOtpModelFromJson(String str) => GenerateOtpModel.fromJson(json.decode(str));

String generateOtpModelToJson(GenerateOtpModel data) => json.encode(data.toJson());

class GenerateOtpModel {
  GenerateOtpModel({
    this.message,
  });

  String message;

  factory GenerateOtpModel.fromJson(Map<String, dynamic> json) => GenerateOtpModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}