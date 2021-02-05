import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/ui/address/address_screen.dart';
import 'package:greetings_world_shopper/ui/cart/cart.dart';
import 'package:greetings_world_shopper/ui/checkout/checkout.dart';
import 'package:greetings_world_shopper/ui/credit_card/credit_card.dart';
import 'package:greetings_world_shopper/ui/home/home.dart';
import 'package:greetings_world_shopper/ui/login/login.dart';
import 'package:greetings_world_shopper/ui/merchant_detail/merchant_detail.dart';
import 'package:greetings_world_shopper/ui/product_detail/product_detail.dart';
import 'package:greetings_world_shopper/ui/signup/signup.dart';
import 'package:greetings_world_shopper/ui/splash/splash.dart';
import 'package:greetings_world_shopper/ui/web_view/web_view.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/widgets/image_preview.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String merchantDetail = '/merchantDetail';
  static const String productDetail = '/productDetail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String imagePreview = '/imagePreview';
  static const String webView = '/webView';
  static const String creditCard = '/creditCard';
  static const String completeAddress = '/completeAddress';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(), settings: settings);

      case login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);

      case home:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);
      case signUp:
        return PageTransition(
            child: SignupScreen(
              sendResult: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);
      case merchantDetail:
        return PageTransition(
            child: MerchantDetailScreen(
              merchantInfo: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case productDetail:
        return PageTransition(
            child: ProductDetailScreen(
              args: settings.arguments,
            ),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case cart:
        return PageTransition(
            child: CartScreen(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case checkout:
        return PageTransition(
            child: CheckoutScreen(),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case imagePreview:
        return PageTransition(
            child: ImagePreview(
              path: settings.arguments,
            ),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case webView:
        return PageTransition(
            child: WebViewScreen(
              url: settings.arguments,
            ),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);
      case creditCard:
        return PageTransition(
            child: CreditCard(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

        case completeAddress:
        return PageTransition(
            child: AddressScreen(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);
    }
  }
}
