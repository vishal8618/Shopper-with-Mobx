import 'package:flutter/cupertino.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/font_family.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';

enum AppTextStyle { title, medium, regular }

class AppText extends StatelessWidget {
  final String text;
  final dynamic color;
  final bool capitalise;
  final bool align;
  final bool underline;
  final int maxLine;

  final AppTextStyle style;
  final dynamic size;

  AppText({
    @required this.text,
    this.color,
    this.style,
    this.align,
    this.maxLine,
    this.underline,
    this.capitalise,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    ScreenScaler _scaler = ScreenScaler()..init(context);

    var translatedText = "";

    translatedText =
        AppLocalizations.of(context).translate(text == null ? "n" : text);
    translatedText = translatedText == null ? text : translatedText;

    return Text(
      capitalise == null || !capitalise
          ? translatedText
          : translatedText.toUpperCase(),
      textAlign: align == null || !align ? null : TextAlign.center,
       maxLines: maxLine ?? 8,
      style: getStyle(color == null ? AppColors.textColorDark : color,
          size == null ? getTextSize(_scaler) : size,
          underline: underline),

    );
  }

  TextStyle getStyle(Color color, double textSize, {bool underline}) {
    return TextStyle(
        color: color,
        fontFamily: FontFamily.lato,
        fontWeight: getWeight(),
        fontSize: textSize,
        decoration: underline != null ? TextDecoration.underline : null);
  }

  getTextSize(ScreenScaler scaler) {
    switch (style) {
      case AppTextStyle.title:
        return scaler.getTextSize(14);
        break;

      case AppTextStyle.medium:
        return scaler.getTextSize(12);
        break;

      default:
        return scaler.getTextSize(10);
    }
  }

  getWeight() {
    switch (style) {
      case AppTextStyle.title:
        return FontWeight.w900;
        break;

      case AppTextStyle.regular:
        return FontWeight.w200;
        break;

      default:
        return FontWeight.w500;
    }
  }
}
