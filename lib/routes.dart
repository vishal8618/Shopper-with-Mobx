import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/ui/address/address_screen.dart';
import 'package:greetings_world_shopper/ui/cart/cart.dart';
import 'package:greetings_world_shopper/ui/checkout/checkout.dart';
import 'package:greetings_world_shopper/ui/credit_card/credit_card.dart';
import 'package:greetings_world_shopper/ui/home/home.dart';
import 'package:greetings_world_shopper/ui/login/login.dart';
import 'package:greetings_world_shopper/ui/login/verify.dart';
import 'package:greetings_world_shopper/ui/merchant_detail/merchant_detail.dart';
import 'package:greetings_world_shopper/ui/password/forgot.dart';
import 'package:greetings_world_shopper/ui/password/reset_password.dart';
import 'package:greetings_world_shopper/ui/phone_verify_screen/phone_verify.dart';
import 'package:greetings_world_shopper/ui/phone_verify_screen/welcome.dart';
import 'package:greetings_world_shopper/ui/product_detail/product_detail.dart';
import 'package:greetings_world_shopper/ui/profile/shopper_profile.dart';
import 'package:greetings_world_shopper/ui/receipt_details/receipt_details.dart';
import 'package:greetings_world_shopper/ui/receipts/receipts.dart';
import 'package:greetings_world_shopper/ui/shopper_detail/shopper_detail.dart';
import 'package:greetings_world_shopper/ui/signup/signup.dart';
import 'package:greetings_world_shopper/ui/splash/splash.dart';
import 'package:greetings_world_shopper/ui/web_view/web_view.dart';
import 'package:greetings_world_shopper/widgets/image_preview.dart';
import 'package:page_transition/page_transition.dart';

class Routes {
  Routes._();

  //static variables
  static  String currentRoute = '';


  static const String splash = '/splash';
  static const String home = '/home';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String resetPassword = '/resetPassword';
  static const String merchantDetail = '/merchantDetail';
  static const String productDetail = '/productDetail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String imagePreview = '/imagePreview';
  static const String webView = '/webView';
  static const String creditCard = '/creditCard';
  static const String completeAddress = '/completeAddress';
  static const String shopperProfileDetail = '/shopperProfileDetail';
  static const String shopperProfile= '/shopperProfile';
  static const String receipt= '/receipt';
  static const String receiptDetail= '/receiptDetail';
  static const String phoneVerification= '/phoneVerificationScreen';
  static const String verify= '/verificationScreen';
  static const String welcome= '/welcomeScreen';
  static  BuildContext context;

  static Route<dynamic> generateRoute(RouteSettings settings) {

    currentRoute=settings.name;
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
            builder: (_) => SplashScreen(), settings: settings);

      case login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(screenType: settings.arguments), settings: settings);

      case home:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(screenType: settings.arguments), settings: settings);

      case signUp:
        return PageTransition(
            child: SignupScreen(
              sendResult: settings.arguments,
            ),
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case forgotPassword:
        return MaterialPageRoute(
            builder: (_) => ForgotScreen(), settings: settings);

      case resetPassword:
        return MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(message: settings.arguments), settings: settings,);
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
            child: CreditCardScreen(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

        case completeAddress:
        return PageTransition(
            child: AddressScreen( sendResult: settings.arguments,),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case shopperProfileDetail:
        return PageTransition(
            child: ShopperProfileDetail(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case shopperProfile:
        return PageTransition(
            child: ShopperProfile(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case receipt:
        return PageTransition(
            child: ReceiptsScreen(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case receiptDetail:
        return PageTransition(
            child: ReceiptDetailScreen(
              receiptInfo: settings.arguments,
            ),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);


      case phoneVerification:
        return PageTransition(
            child: PhoneVerifyScreen(token: settings.arguments),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case welcome:
        return PageTransition(
            child: WelcomeScreen(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);

      case verify:
        return PageTransition(
            child: VerifyScreen(),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            settings: settings);
    }
  }
}
