import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/dynamic_link_service.dart';

abstract class Bloc {
  void dispose();
}

class DeepLinkBloc extends Bloc {
/*//Event Channel creation
  static const stream = const EventChannel('com.deeplink.flutter.dev/events');
//Method channel creation
  static const platform =
      const MethodChannel('com.deeplink.flutter.dev/channel');*/

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;
  DynamicLinkService _dynamicLinkService;

//Adding the listener into contructor
  DeepLinkBloc(UserStore userStore, GlobalKey<NavigatorState> navigatorKey) {
    _dynamicLinkService = DynamicLinkService();
    _dynamicLinkService.retrieveDynamicLink(userStore, this, navigatorKey);
//Checking application start by deep link
   // print('P====> DeepLinkBloc');
//     startUri().then(_onRedirected);
// //Checking broadcast stream, if deep link was clicked in opened appication
//     stream.receiveBroadcastStream().listen((d) {
//       _onRedirected(d);
//
//     });
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
      stateSink.add(uri);
      if (Navigator.of(Routes.context).canPop()) Navigator.pop(Routes.context);
      Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.phoneVerification, (route) => false);
    }
  }

  @override
  void dispose() {
    _stateController.close();
  }

  // Future<String> startUri() async {
  //   try {
  //     return platform.invokeMethod('initialLink');
  //   } on PlatformException catch (e) {
  //     return "Failed to Invoke: '${e.message}'.";
  //   }
  // }

  void navigateToSettingScreen() async {
  //  if(userStore.isLoggedIn){
      Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
    // }else{
    //   Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
    // }
  }


}



