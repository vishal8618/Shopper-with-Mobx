import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/shape_of_view/shape/circle.dart';
import 'package:greetings_world_shopper/widgets/shape_of_view/shape_of_view.dart';



class CommonDecorations {


static Widget getSocialIcon(_scaler,String icon ){
    return ShapeOfView(
      shape: CircleShape(
        borderColor: Colors.white,
        borderWidth: 2.0,
      ),
      child: Container(
        color: Colors.transparent,
        padding: _scaler.getPadding(1.2, 1.3),
        child: ImageView(
          width: _scaler.getWidth(3.0),
          height: _scaler.getWidth(3.0),
          path: icon,
        ),
      ),
    );
}

}