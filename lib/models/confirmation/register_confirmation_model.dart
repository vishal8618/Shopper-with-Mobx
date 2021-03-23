// To parse this JSON data, do
//
//     final registerConfirmationModel = registerConfirmationModelFromJson(jsonString);

import 'dart:convert';

RegisterConfirmationModel registerConfirmationModelFromJson(String str) => RegisterConfirmationModel.fromJson(json.decode(str));

String registerConfirmationModelToJson(RegisterConfirmationModel data) => json.encode(data.toJson());

class RegisterConfirmationModel {
  RegisterConfirmationModel({
    this.message,
  });

  String message;

  factory RegisterConfirmationModel.fromJson(Map<String, dynamic> json) => RegisterConfirmationModel(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
