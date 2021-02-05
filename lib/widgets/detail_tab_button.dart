import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';

import 'app_text.dart';

class DetailTabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool selected;

  DetailTabButton({this.text, this.onPressed, this.selected});

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    return Material(
      elevation: 0,
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: _scaler.getPadding(1, 0),
          alignment: Alignment.center,
          child: AppText(
            text: text,
            style: AppTextStyle.medium,
            size: _scaler.getTextSize(11.0),
            color: selected ? AppColors.primaryColor : AppColors.textColorDark,
          ),
        ),
      ),
    );
  }
}
