import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/font_family.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchFieldSate createState() => _SearchFieldSate();

  final String hintText;
  final TextInputAction action;
  final TextInputType inputType;
  final Function(String) onType;
  final Function(String) onSubmit;
  final Function(String) onSelected;
  final TextEditingController controller;

  SearchField(
      {@required this.hintText,
      this.action,
      this.inputType,
      this.controller,
      this.onType,
      this.onSelected,
      this.onSubmit});
}

class _SearchFieldSate extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    var hint = "";
    hint = AppLocalizations.of(context)
        .translate(widget.hintText == null ? "n" : widget.hintText);
    hint = hint == null ? widget.hintText : hint;

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
          autofocus: false,
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSubmit,
          controller: widget.controller,
          style: textFieldStyle(_scaler.getTextSize(12)),
          decoration: inputDecorationWithCurve(hint, _scaler)),
      suggestionsCallback: (data) async {
        return await widget.onType(data);
      },
      noItemsFoundBuilder: (context) {
        return Container(
          height: 0,
        );
      },
      errorBuilder: (context, error) {
        return Container(
          height: 0,
        );
      },
      loadingBuilder: (context) {
        return Container(
          height: 0,
        );
      },
      itemBuilder: (context, suggestion) {
        return Container(
          alignment: Alignment.centerLeft,
          color: AppColors.bg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: _scaler.getPadding(0.8, 1),
                child: AppText(
                  text: suggestion,
                  style: AppTextStyle.medium,
                  color: AppColors.textColorDark,
                  size: _scaler.getTextSize(11),
                ),
              ),
              Divider(
                color: AppColors.textColorLight,
                height: 0,
                thickness: 1,
              )
            ],
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        widget.onSelected(suggestion);
        // widget.controller.text = suggestion;
      },
    );
  }

  InputDecoration inputDecorationWithCurve(
    String fieldname,
    ScreenScaler scaler,
  ) {
    return InputDecoration(
      hintText: fieldname,
      errorMaxLines: 1,
      errorStyle: TextStyle(fontSize: 0, height: 0),
      isDense: false,
      suffixIcon: IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.grey,
          size: scaler.getTextSize(12),
        ),
        onPressed: () {
          widget.controller.text = "";
          widget.onSubmit("");
          DeviceUtils.hideKeyboard(context);
        },
      ),
      prefixIcon: Icon(
        Icons.search,
        color: Colors.grey,
        size: scaler.getTextSize(12),
      ),
      filled: true,
      hintStyle: textMedium(Colors.grey, scaler.getTextSize(12)),
      fillColor: AppColors.bg,
      enabledBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey)),
      disabledBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey)),
      focusedBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey)),
      errorBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.red)),
      focusedErrorBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.red)),
    );
  }

  static TextStyle textFieldStyle(double size) {
    return TextStyle(
        color: AppColors.textColorDark,
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
