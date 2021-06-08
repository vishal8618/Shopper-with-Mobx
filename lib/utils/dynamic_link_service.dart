import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/constants/deep_link_navigation_helper.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';

class DynamicLinkService {
  Future<void> retrieveDynamicLink(UserStore userStore, DeepLinkBloc bloc,
      GlobalKey<NavigatorState> navigatorKey) async {
    try {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;

      if (deepLink != null) {
        _onRedirected(deepLink.toString(), userStore, bloc, navigatorKey);
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        _onRedirected(
            dynamicLink.link.toString(), userStore, bloc, navigatorKey);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _onRedirected(String uri, UserStore userStore, DeepLinkBloc bloc,
      GlobalKey<NavigatorState> navigatorKey) {
    print('link: $uri');
    if (uri.contains("settings")) {
      navigateToSettingScreen(userStore, navigatorKey);
    } else {
      final splitInviteLink = uri.split('/');
      final inviteToken = splitInviteLink[splitInviteLink.length - 1];

      print('P====> receiveBroadcastStream $uri');
      print('P====> _onRedirected $uri');
      bloc.stateSink.add(uri);
      if (Navigator.of(Routes.context).canPop()) Navigator.pop(Routes.context);
      navigatorKey.currentState
          .pushNamedAndRemoveUntil(Routes.phoneVerification, (route) => false);
    }
  }

  void navigateToSettingScreen(
      UserStore userStore, GlobalKey<NavigatorState> navigatorKey) async {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (userStore.isLoggedIn) {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.home, (route) => false,
            arguments: DeepLinkNavigationHelper.openSettingScreen);
      } else {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.login, (route) => false,
            arguments: DeepLinkNavigationHelper.openSettingScreen);
      }
    });
  }
}
