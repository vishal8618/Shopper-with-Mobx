import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/font_family.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';

class PhoneTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode node;
  final FocusNode nextNode;
  final TextInputAction action;
  final TextInputType inputType;
  final bool editabled;
  final Widget suffix;
  final Widget prefix;

  bool has = false;

  final bool password;
  final int maxLength;
  final int maxLines;
  final Function(String) validate;

  PhoneTextField({
    @required this.hintText,
    @required this.controller,
    this.node,
    this.nextNode,
    this.password,
    this.maxLength,
    this.action,
    this.validate,
    this.editabled,
    this.suffix,
    this.prefix,
    this.inputType,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);
    var hint = "";
    hint = AppLocalizations.of(context)
        .translate(hintText == null ? "n" : hintText);
    hint = hint == null ? hintText : hint;

    return TextFormField(
      inputFormatters: inputType == TextInputType.name
          ? [
        new FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
      ]
          : inputType == TextInputType.number
          ? [
        new FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ]
          : inputType == TextInputType.emailAddress
          ? [
        new FilteringTextInputFormatter.allow(RegExp('[a-z0-9@.]')),
      ]
          : null,
      controller: controller,
      enabled: editabled == null ? true : editabled,
      focusNode: node == null ? null : node,
      maxLength: maxLength ?? null,
      cursorColor: Colors.red,
      obscureText: password != null && password,
      textInputAction: action == null ? TextInputAction.done : action,
      decoration: inputDecorationWithCurve(hint, _scaler,
          prefix: prefix, suffix: suffix),
      keyboardType: inputType == null ? TextInputType.text : inputType,
      textCapitalization: TextCapitalization.none,
      validator: validate ?? validate,
      style: textFieldStyle(_scaler.getTextSize(11)),
      maxLines: maxLines ?? null,
    );
  }

  InputDecoration inputDecorationWithCurve(
      String fieldName, ScreenScaler scaler,
      {Widget suffix, Widget prefix}) {
    return InputDecoration(
      hintText: fieldName,
      counterText: "",
      errorMaxLines: 1,
      isDense: false,
      suffixIcon: suffix == null ? null : suffix,
      prefixIcon: prefix == null ? null : prefix,
      hintStyle: textMedium(Colors.grey, scaler.getTextSize(11)),
      contentPadding: scaler.getPaddingLTRB(0, 1.3, 1, 1.4),
      fillColor: AppColors.bg,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
      ),
      disabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 0.5),
      ),
    );
  }

  static TextStyle textFieldStyle(double size) {
    return TextStyle(
        color: Colors.black,
        fontFamily: FontFamily.lato,
        fontWeight: FontWeight.w500,
        fontSize: size);
  }

  static TextStyle textMedium(Color color, double textSize, {bool underline}) {
    return TextStyle(
        color: color,
        fontFamily: FontFamily.lato,
        fontWeight: FontWeight.w500,
        fontSize: textSize,
        decoration: underline != null ? TextDecoration.underline : null);
  }
}
