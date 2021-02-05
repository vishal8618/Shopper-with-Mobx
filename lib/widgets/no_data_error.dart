import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:lottie/lottie.dart';

class NoDataError extends StatelessWidget {
  final String message;

  NoDataError({this.message});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler=ScreenScaler()..init(context);
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          Assets.lottieNoDataError,
          repeat: false,
          animate: true,
          width: scaler.getWidth(50)
        ),
        SizedBox(height: scaler.getHeight(1),),
        AppText(text: message??"",size: scaler.getTextSize(12),)

      ],
    );
  }
}
