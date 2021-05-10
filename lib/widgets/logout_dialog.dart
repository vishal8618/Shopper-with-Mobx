import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

// ignore: must_be_immutable
class LogoutDialog extends StatelessWidget {
  final VoidCallback yesClick;
  ScreenScaler _scaler;

  LogoutDialog(
      {@required this.yesClick });

  @override
  Widget build(BuildContext context) {
    _scaler = new ScreenScaler()..init(context);

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: _scaler.getPadding(2, 1),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppText(
              text: Strings.logoutTitle,
              style: AppTextStyle.title,
              size: _scaler.getTextSize(12),
            ),
            SizedBox(
              height: _scaler.getHeight(1),
            ),
            AppText(
              text: Strings.logoutDesc,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(10),
            ),
            _buildButtons(context)
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(context) {
    return Column(
      children: [
        SizedBox(
          height: _scaler.getHeight(1),
        ),
        Container(
          width: _scaler.getWidth(100),
          margin: _scaler.getMargin(1, 3),
          child: MaterialButton(
            height: _scaler.getHeight(3.5),
            padding: _scaler.getPadding(1, 0),
            color: AppColors.buttonBg,
            onPressed: yesClick,
            child: AppText(
              text: Strings.logoutYes,
              color: Colors.white,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(11),
            ),
          ),
        ),
        Container(
          width: _scaler.getWidth(100),
          margin: _scaler.getMargin(0, 3),
          child: MaterialButton(
            height: _scaler.getHeight(3.5),
            padding: _scaler.getPadding(1, 0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  color: AppColors.buttonBg,
                )),
            onPressed:()=>  Navigator.of(context).pop(),
            child: AppText(
              text: Strings.logoutNo,
              color: AppColors.buttonBg,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(11),
            ),
          ),
        )
      ],
    );
  }
}
