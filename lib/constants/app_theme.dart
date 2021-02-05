import 'package:flutter/material.dart';
import 'colors.dart';
import 'font_family.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.lato,
    brightness: Brightness.light,

    // primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: AppColors.primaryColor,
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.primaryColor1,
    canvasColor: AppColors.primaryColor1,
    appBarTheme:
        AppBarTheme(iconTheme: IconThemeData(color: AppColors.starYellow)),
    accentColorBrightness: Brightness.light);
