import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';

class ReportDialog extends StatefulWidget {
  final Function(String) callback;

  ReportDialog({this.callback});

   @override
   _ReportDialogState createState() => _ReportDialogState();

}


class _ReportDialogState extends State<ReportDialog>{
  ScreenScaler _scaler;
  var reportController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     _scaler= ScreenScaler()..init(context);

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
                text: Strings.reasonTitle,
                style: AppTextStyle.title,
                size: _scaler.getTextSize(12),
              ),
              SizedBox(
                height: _scaler.getHeight(1),
              ),
              AppTextField(
                hintText: "Enter your reason",
                controller: reportController,
                inputType: TextInputType.text,
                validate: (text){
                  if(text.trim().isEmpty){
                    return 'Required Reason';
                  } else {
                    return null;
                  }

                },
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
              if(formKey.currentState.validate()){
                widget.callback(reportController.text);
              }else{
                return 'Required Reason';
              }

              Navigator.pop(context);
            },
            child: AppText(
              text: Strings.reportNow,
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
