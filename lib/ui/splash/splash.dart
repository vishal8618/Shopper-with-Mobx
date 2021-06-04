import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/ui/login/login.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common.dart';
import '../../routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //Event Channel creation
  static const stream = const EventChannel('com.deeplink.flutter.dev/events');
//Method channel creation
  static const platform =
  const MethodChannel('com.deeplink.flutter.dev/channel');

  @override
  void initState() {
    super.initState();
    startUri().then(_onRedirected);
//Checking broadcast stream, if deep link was clicked in opened appication
    stream.receiveBroadcastStream().listen((d) {
      _onRedirected(d);

    });
    startTimer();
  }

  ScreenScaler _scaler;
  UserStore _userStore;
  DeepLinkBloc _bloc;
  // bool shouldOpen=true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
     _bloc = Provider.of<DeepLinkBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
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

  _onRedirected(String uri) {
    print('link: $uri');
    if(uri.contains("settings")){
      navigateToSettingScreen();
    }else{
      final splitInviteLink = uri.split('/');
      final inviteToken = splitInviteLink[splitInviteLink.length - 1];

      print('P====> receiveBroadcastStream $uri');
      print('P====> _onRedirected $uri');
      _bloc.stateSink.add(uri);
      if (Navigator.of(Routes.context).canPop()) Navigator.pop(Routes.context);
      Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.phoneVerification, (route) => false);
    }
  }

  void navigateToSettingScreen() async {
    //  if(userStore.isLoggedIn){
    Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
    // }else{
    //   Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
    // }
  }

  Future<String> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }

}
