import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';

import 'app_text.dart';

class TabButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool selected;

  TabButton({this.text, this.onPressed, this.selected});

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    return Material(
      elevation: 1,
      color: selected?AppColors.primaryColor:AppColors.bg,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: _scaler.getPadding(1, 0),
          alignment: Alignment.center,
          child: AppText(
            text: text,
            style: AppTextStyle.medium,
            size: _scaler.getTextSize(11),
            color: selected ? AppColors.bg : AppColors.textColorDark,
          ),
        ),
      ),
    );
  }
}
