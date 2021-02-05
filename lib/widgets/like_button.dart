import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:like_button/like_button.dart';

class LikeWidget extends StatefulWidget {
  bool liked;
  Function(bool) likeCallback;

  LikeWidget({this.liked, this.likeCallback});

  _ScaleTransitionExampleState createState() => _ScaleTransitionExampleState();
}

class _ScaleTransitionExampleState extends State<LikeWidget>
    with TickerProviderStateMixin {
  ScreenScaler _scaler;

  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return LikeButton(
      circleColor: CircleColor(
          start: AppColors.primaryColor1, end: AppColors.primaryColor),
      bubblesColor: BubblesColor(
        dotPrimaryColor: AppColors.primaryColor1,
        dotSecondaryColor: AppColors.primaryColor,
      ),
      isLiked: widget.liked,

      likeBuilder: (bool isLiked) {
        if(isLiked!=widget.liked)
          widget.likeCallback(isLiked);

        return Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color:
          isLiked ? AppColors.primaryColor : AppColors.textColorDark,
          size: _scaler.getTextSize(14),
        );
      },
    );
  }
}
