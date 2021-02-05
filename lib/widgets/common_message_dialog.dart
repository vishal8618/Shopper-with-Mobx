import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

class CommonMessageDialog extends StatelessWidget {
  final String title;
  final String message;

  CommonMessageDialog({@required this.message, this.title});

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = new ScreenScaler()..init(context);

    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: _scaler.getPadding(1, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppText(
              text: title ?? "",
              style: AppTextStyle.title,
              size: _scaler.getTextSize(12),
            ),
            SizedBox(
              height: _scaler.getHeight(1),
            ),
            AppText(
              text: message ?? "",
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(10),
            ),
            _buildButtons(context, _scaler)
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(context, ScreenScaler _scaler) {
    return Column(
      children: [
        SizedBox(
          height: _scaler.getHeight(1),
        ),
        Container(
          width: _scaler.getWidth(100),
          margin: _scaler.getMargin(0.5, 3),
          child: MaterialButton(
            height: _scaler.getHeight(3.5),
            padding: _scaler.getPadding(1, 0),
            color: AppColors.buttonBg,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: AppText(
              text: Strings.dismiss,
              color: Colors.white,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(11),
            ),
          ),
        ),
      ],
    );
  }
}
