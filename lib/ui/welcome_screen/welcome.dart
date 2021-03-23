
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

import '../../routes.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  ScreenScaler _scaler;
  @override
  void initState() {
    super.initState();
   // startTimer();
  }


  @override
  Widget build(BuildContext context) {
    if (_scaler == null) _scaler = ScreenScaler()..init(context);
    return Material(
    child: Center(
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.splashGradient),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppText(
              text: Strings.confirmationTitle,
              style: AppTextStyle.title,
              size: _scaler.getTextSize(14),
              color: Colors.white,
            ),
            SizedBox(
              height: _scaler.getHeight(1),
            ),
            AppText(
              text: Strings.verifyRegistration,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(10.5),
              color: Colors.white,
            ),
            _buildButtons(context)
          ],
        ),
      ),
    ),
    );

  }

 /* startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    Navigator.of(context).pushReplacementNamed(Routes.login);
  }*/

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
            onPressed: (){
              Navigator.of(context).pushReplacementNamed(Routes.login);
            },
            child: AppText(
              text: "Ok",
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