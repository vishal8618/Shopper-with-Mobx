import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';

class ReceiptsScreen extends StatefulWidget {
  @override
  _ReceiptsScreenState createState() => _ReceiptsScreenState();
}

class _ReceiptsScreenState extends State<ReceiptsScreen> {
  ScreenScaler _scaler;

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: ListView(
        padding: _scaler.getPadding(1, 2),
        children: [getItem(), getItem(), getItem()],
      ),
    );
  }

  Widget getItem() {
    return Container(
      margin: _scaler.getMarginLTRB(0, 0, 0, 1),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: _scaler.getBorderRadiusCircular(4)),
      padding: _scaler.getPadding(0.5, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageView(
                path: Assets.logo,
                width: _scaler.getWidth(15),
                height: _scaler.getWidth(15),
                color: AppColors.textColorDark,
              ),
              SizedBox(
                width: _scaler.getWidth(2),
              ),
              Align(
                alignment: Alignment.topRight,
                child: AppText(
                  text: "Receipt #123456",
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(10),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline_rounded,
                  color: AppColors.primaryColor, size: _scaler.getTextSize(14)),
              SizedBox(
                width: _scaler.getWidth(1),
              ),
              Container(
                alignment: Alignment.center,
                padding: _scaler.getPadding(0.3, 0.3),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 2)),
                child: Icon(
                  Icons.share,
                  color: AppColors.primaryColor,
                  size: _scaler.getTextSize(10.5),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
