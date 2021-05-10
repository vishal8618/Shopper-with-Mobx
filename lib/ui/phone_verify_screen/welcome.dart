import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/ui/login/login.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common.dart';
import '../../routes.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  ScreenScaler _scaler;
  UserStore _userStore;

  // bool shouldOpen=true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    if (_scaler == null) _scaler = ScreenScaler()..init(context);
    return Material(
      child: Container(
          padding: _scaler.getPadding(1, 1),
          decoration: BoxDecoration(gradient: AppColors.splashGradient),
          child: Column(
            children: [
              SizedBox(
                height: _scaler.getHeight(30),
              ),
              AppText(
                text:
                    "Your email & phone verification is done , Now you are proceed to login",
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(12),
                color: Colors.yellow,
                align: true,
              ),
              SizedBox(
                height: _scaler.getHeight(3),
              ),
              Container(
                  width: _scaler.getWidth(100),
                  margin: _scaler.getMargin(1, 3),
                  child: MaterialButton(
                    height: _scaler.getHeight(3.5),
                    padding: _scaler.getPadding(1, 2),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          Routes.login, (route) => false);
                    },
                    child: AppText(
                      text: "Ok",
                      color: Colors.purple,
                      style: AppTextStyle.medium,
                      size: _scaler.getTextSize(11),
                    ),
                  )),
            ],
          )),
    );
  }
}
