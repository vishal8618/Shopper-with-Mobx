import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';

  class SuccessBar {

  static showMessage(String message, BuildContext context){
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          duration: Duration(seconds: 1),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

}