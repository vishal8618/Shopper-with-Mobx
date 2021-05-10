
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const primaryColor = Color(0xFF902A99);
  static const primaryColor1 = Color(0xFFA92fd9);
  static const buttonBg = Color(0xFF57256D);
  static const yellow = Color(0xFFDABB5B);
  static const starYellow = Color(0xFFE6BA27);
  static const textColorDark = Color(0xFF6C6F73);
  static const bg = Color(0xFFF0F0F0);
  static const deselectedIcon = Color(0xFFDBC5DD);
  static const textColorLight = Color(0xFFBBBBBB);

  //click splash colors
  static const splashWhite = Color(0x50ffffff);




  //gradients
  static var splashGradient = LinearGradient(
      colors: [Color(0xFFD930C8), Color(0xFF5C2573)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static var appBarGradient =
      LinearGradient(colors: [primaryColor, primaryColor1]);

  static var transParentGradient = LinearGradient(
    colors: [ Colors.transparent,Colors.black.withOpacity(0.9)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );


  static var primaryGradient = LinearGradient(
      colors: [primaryColor, Colors.transparent.withOpacity(0) ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

}
