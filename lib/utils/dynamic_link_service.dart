import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/constants/deep_link_navigation_helper.dart';
import 'package:greetings_world_shopper/data/sharedpref/shared_preference_helper.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DynamicLinkService {
  Future<void> retrieveDynamicLink(UserStore userStore, DeepLinkBloc bloc,
      GlobalKey<NavigatorState> navigatorKey) async {
    try {
      final PendingDynamicLinkData data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri deepLink = data?.link;
      if (deepLink != null) {
        _onRedirected(
            deepLink.toString(), userStore, bloc, navigatorKey, deepLink);
      }

      FirebaseDynamicLinks.instance.onLink(
          onSuccess: (PendingDynamicLinkData dynamicLink) async {
        _onRedirected(dynamicLink.link.toString(), userStore, bloc,
            navigatorKey, dynamicLink.link);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _onRedirected(
    String uri,
    UserStore userStore,
    DeepLinkBloc bloc,
    GlobalKey<NavigatorState> navigatorKey,
    Uri deepLink,
  ) {
    print('===> link: $uri');
    if (uri.contains("settings")) {
      // print('===> link IF: $uri');
      navigateToSettingScreen(userStore, navigatorKey);
    } else if (uri.contains("token")) {
      // print('===> link ELSE IF: $uri');
      var queryParameters = deepLink.queryParameters;
      var link = queryParameters["link"];

      if (link != null) {
        var data = link.split("_");
        if (data != null && data.length > 1) {
          var token = data[1];
          Future.delayed(Duration(milliseconds: 500)).then((value) {
            Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
                Routes.phoneVerification, (route) => false,
                arguments: token);
          });
        }
      }
    } else if (uri.contains("orderId")) {
      var queryParameters = deepLink.queryParameters;
      var link = queryParameters["link"];

      if (link != null) {
        var data = link.split("_");
        if (data != null && data.length > 1) {
          var order_id = data[1];
          // print('===> link ELSE LAST: $queryParameters ,, $link');
          navigateToReceiptDetailScreen(userStore, navigatorKey, order_id);
        }
      }
    } else if (uri.contains("cart")) {
      // print('===> link IF: $uri');
      navigateToCartScreen(userStore, navigatorKey);
    } else if (uri.contains("merchantId")) {
      var queryParameters = deepLink.queryParameters;
      var link = queryParameters["link"];

      if (link != null) {
        var data = link.split("_");
        if (data != null && data.length > 1) {
          var merchantId = data[1];
          // print('===> link ELSE LAST: $queryParameters :- $link :- $merchantId');
          navigateToMerchantProductsScreen(userStore, navigatorKey, merchantId);
        }
      }
    }
  }

  void navigateToSettingScreen(
      UserStore userStore, GlobalKey<NavigatorState> navigatorKey) async {
    Future.delayed(Duration(milliseconds: 500)).then((value) {
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

  void navigateToReceiptDetailScreen(UserStore userStore,
      GlobalKey<NavigatorState> navigatorKey, String orderId) async {

    Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = new SharedPreferenceHelper(sharedPref);
    _sharedPrefsHelper.saveOrderID(int.parse(orderId));

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      if (userStore.isLoggedIn) {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.home, (route) => false,
            arguments: Routes.receiptDetail);
      } else {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.login, (route) => false,
            arguments: Routes.receiptDetail);
      }
    });
  }

  void navigateToCartScreen(
      UserStore userStore, GlobalKey<NavigatorState> navigatorKey) async {
    Future.delayed(Duration(milliseconds: 100)).then((value) {
      if (userStore.isLoggedIn) {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.home, (route) => false,
            arguments: Routes.cart);

      } else {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.login, (route) => false,
            arguments: Routes.cart);
      }
    });
  }

  void navigateToMerchantProductsScreen(UserStore userStore,
      GlobalKey<NavigatorState> navigatorKey, String merchantId) async {

    Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();
    SharedPreferenceHelper _sharedPrefsHelper = new SharedPreferenceHelper(sharedPref);
    _sharedPrefsHelper.saveMerchantID(int.parse(merchantId));
    _sharedPrefsHelper.saveMerchantTab(1);

    Future.delayed(Duration(milliseconds: 100)).then((value) {
      if (userStore.isLoggedIn) {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.home, (route) => false,
            arguments: Routes.merchantDetail);
      } else {
        Navigator.of(navigatorKey.currentContext).pushNamedAndRemoveUntil(
            Routes.login, (route) => false,
            arguments: Routes.merchantDetail);
      }
    });
  }

}
