import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/deep_link_navigation_helper.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/ui/login/login.dart';
import 'package:greetings_world_shopper/utils/dynamic_link_service.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  Timer _timerLink;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  ScreenScaler _scaler;
  UserStore _userStore;
 // DeepLinkBloc _bloc;
  // bool shouldOpen=true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
   //  _bloc = Provider.of<DeepLinkBloc>(context);
  }


  @override
  Widget build(BuildContext context) {
    Routes.context=context;
    if (_scaler == null) _scaler = ScreenScaler()..init(context);

    return Material(
      child:Container(
        decoration: BoxDecoration(gradient: AppColors.splashGradient),
        child: ImageView(
          path: Assets.logo,
          color: AppColors.starYellow,
          height: _scaler.getHeight(50),
          width: _scaler.getWidth(50),
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 3000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    if(_userStore.isLoggedIn){
      Navigator.of(context).pushReplacementNamed(Routes.home);
    }else{
      Navigator.of(context).pushReplacementNamed(Routes.login);
    }
  }
}
