import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:greetings_world_shopper/routes.dart';


abstract class Bloc {
  void dispose();
}

class DeepLinkBloc extends Bloc {
//Event Channel creation
  static const stream = const EventChannel('com.deeplink.flutter.dev/events');
//Method channel creation
  static const platform =
      const MethodChannel('com.deeplink.flutter.dev/channel');

  StreamController<String> _stateController = StreamController();

  Stream<String> get state => _stateController.stream;

  Sink<String> get stateSink => _stateController.sink;

//Adding the listener into contructor
  DeepLinkBloc() {
//Checking application start by deep link
    print('P====> DeepLinkBloc');
    startUri().then(_onRedirected);
//Checking broadcast stream, if deep link was clicked in opened appication
    stream.receiveBroadcastStream().listen((d) {
      final splitInviteLink = d.split('/');
      final inviteToken = splitInviteLink[splitInviteLink.length - 1];

      print('P====> receiveBroadcastStream $d');
      _onRedirected(d);
    });
  }

  _onRedirected(String uri) {
    print('P====> _onRedirected $uri');
    stateSink.add(uri);
    if (Navigator.of(Routes.context).canPop()) Navigator.pop(Routes.context);
    Navigator.of(Routes.context).pushNamedAndRemoveUntil(Routes.phoneVerification, (route) => false);


  }

  @override
  void dispose() {
    _stateController.close();
  }

  Future<String> startUri() async {
    try {
      return platform.invokeMethod('initialLink');
    } on PlatformException catch (e) {
      return "Failed to Invoke: '${e.message}'.";
    }
  }


}



