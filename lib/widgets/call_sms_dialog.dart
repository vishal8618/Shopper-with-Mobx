import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

class CallSMSDialog extends StatelessWidget {
  final VoidCallback callClick;
  final VoidCallback smsClick;
  final VoidCallback cancelClick;

  CallSMSDialog(
      {@required this.callClick,
      @required this.smsClick,
      @required this.cancelClick});

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = new ScreenScaler()..init(context);
    DeviceUtils.hideKeyboard(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                    alignment: Alignment.center,
                    child: AppText(
                      text: "Choose Action",
                      color: Colors.white,
                    )),
              ),
            ),
            GestureDetector(
                onTap: callClick,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText(
                    text: "Call",
                  ),
                )),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: smsClick,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AppText(
                  text: "SMS",
                ),
              ),
            ),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: cancelClick,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AppText(
                  text: "Cancel",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
