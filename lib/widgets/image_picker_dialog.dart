import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback galleryClick;
  final VoidCallback cameraClick;
  final VoidCallback cancelClick;

  ImagePickerDialog(
      {@required this.galleryClick,
      @required this.cameraClick,
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
                      text: "Choose From",
                      color: Colors.white,
                    )),
              ),
            ),
            GestureDetector(
                onTap: galleryClick,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText(
                    text: "Gallary",
                  ),
                )),
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: cameraClick,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AppText(
                  text: "Capture",
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
