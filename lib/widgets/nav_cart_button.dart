import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';

import '../routes.dart';
import 'app_text.dart';
import 'image_view.dart';

class NavCartButton extends StatelessWidget {
  final int items;
VoidCallback callback;
  NavCartButton({this.items,this.callback});

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    return Container(
      alignment: Alignment.center,
      padding: _scaler.getPadding(0, 1),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topRight,
            margin: _scaler.getMargin(0, 1),
            width: _scaler.getWidth(8),
            height: _scaler.getWidth(10),
            child: AppText(
              text:items==0?"": items.toString(),
              color: Colors.white,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(10),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: callback==null?() {
                DeviceUtils.hideKeyboard(context);
                Navigator.of(context).pushNamed(Routes.cart);
              }:callback,
              child: ImageView(
                path: Assets.cart,
                color: AppColors.starYellow,
                width: _scaler.getWidth(6),
              ),
            ),
          )
        ],
      ),
    );
  }
}
