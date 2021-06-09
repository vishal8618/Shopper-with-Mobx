import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';

  class ErrorBar {

  static showMessage(String message, BuildContext context, {Duration duration}){
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          duration: duration ?? Duration(seconds: 1),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

}