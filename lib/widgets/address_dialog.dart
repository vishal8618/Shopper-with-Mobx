import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';

import '../routes.dart';
import 'app_text.dart';
import 'app_text_field.dart';

class AddressDialog extends StatefulWidget {
  final Function(String) callback;

  AddressDialog({this.callback});

  @override
  _AddressDialogState createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  ScreenScaler _scaler;
  var reportController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return Dialog(
      backgroundColor: Colors.white,
      child: Form(
        key: formKey,
        child: Container(
          padding: _scaler.getPadding(2, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppText(
                text: Strings.addAddress,
                style: AppTextStyle.title,
                size: _scaler.getTextSize(12),
              ),
              SizedBox(
                height: _scaler.getHeight(1),
              ),
              _buildButtons(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(context) {
    return Column(
      children: [
        SizedBox(
          height: _scaler.getHeight(1),
        ),
        Container(
          width: _scaler.getWidth(100),
          margin: _scaler.getMargin(0, 3),
          child: MaterialButton(
            height: _scaler.getHeight(3.5),
            padding: _scaler.getPadding(1, 0),
            color: AppColors.primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(Routes.completeAddress,
                  arguments: 'addressDialog');
            },
            child: AppText(
              text: Strings.address,
              color: Colors.white,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(11),
            ),
          ),
        ),
        Container(
          width: _scaler.getWidth(100),
          margin: _scaler.getMargin(0, 3),
          child: MaterialButton(
            height: _scaler.getHeight(3.5),
            padding: _scaler.getPadding(1, 0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
                side: BorderSide(
              width: 1,
              color: AppColors.buttonBg,
            )),
            onPressed: () => Navigator.of(context).pop(),
            child: AppText(
              text: Strings.cancel,
              color: AppColors.buttonBg,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(11),
            ),
          ),
        )
      ],
    );
  }
}
