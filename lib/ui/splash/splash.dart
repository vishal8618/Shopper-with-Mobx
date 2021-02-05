import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  ScreenScaler _scaler;
  UserStore _userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_scaler == null) _scaler = ScreenScaler()..init(context);

    return Material(
      child: Container(
        decoration: BoxDecoration(gradient: AppColors.splashGradient),
        child: ImageView(
          path: Assets.logo,
          color: AppColors.starYellow,
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    if (_userStore.isLoggedIn) {
      Navigator.of(context).pushReplacementNamed(Routes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
