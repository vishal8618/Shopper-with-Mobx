import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';

// ignore: must_be_immutable
class DeliveryTypeDialog extends StatefulWidget {
  final ValueChanged yesClick;

  final List<String> deliverTypes;

  DeliveryTypeDialog({@required this.yesClick, this.deliverTypes});

  @override
  State<StatefulWidget> createState() {
    return DeliveryTypeDialogState(yesClick, deliverTypes);
  }
}

class DeliveryTypeDialogState extends State<DeliveryTypeDialog> {
  final ValueChanged yesClick;

  final List<String> deliverTypes;

  int selectedPosition = 0;

  ScreenScaler _scaler;

  DeliveryTypeDialogState(this.yesClick, this.deliverTypes);

  @override
  Widget build(BuildContext context) {
    _scaler = new ScreenScaler()..init(context);
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        padding: _scaler.getPadding(2, 1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AppText(
              text: Strings.deliveryTypes,
              style: AppTextStyle.title,
              size: _scaler.getTextSize(12),
            ),
            SizedBox(
              height: _scaler.getHeight(1),
            ),
            Container(
                constraints: BoxConstraints(maxHeight: 400.0),
                child: _buildButtons(context)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: AppText(
                    text: Strings.cancel,
                    color: AppColors.buttonBg,
                    style: AppTextStyle.medium,
                    size: _scaler.getTextSize(11),
                  ),
                ),
                SizedBox(
                  width: _scaler.getWidth(4.0),
                ),
                InkWell(
                  onTap: () {
                    yesClick(deliverTypes[selectedPosition]);
                  },
                  child: AppText(
                    text: Strings.proceed,
                    color: AppColors.buttonBg,
                    style: AppTextStyle.medium,
                    size: _scaler.getTextSize(11),
                  ),
                ),
                SizedBox(
                  width: _scaler.getWidth(2.0),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return itemRow(index, deliverTypes[index]);
      },
      itemCount: deliverTypes.length,
      shrinkWrap: true,
    );
  }

  Widget itemRow(int index, String deliverType) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedPosition = index;
        });
      },
      leading: Checkbox(
        value: selectedPosition == index,
        onChanged: (value) {
          setState(() {
            selectedPosition = index;
          });
        },
      ),
      title: AppText(
        text: deliverType,
        color: AppColors.buttonBg,
        style: AppTextStyle.medium,
        size: _scaler.getTextSize(11),
      ),
    );
  }
}
