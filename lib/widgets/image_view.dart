import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class ImageView extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final File file;
  final bool circleCrop;
  final BoxFit fit;
  final Color color;
  final double radius;
  final double border;

  const ImageView(
      {Key key,
      this.path,
      this.width,
      this.height,
      this.file,
      this.circleCrop = false,
      this.fit,
      this.radius = 20.0,
      this.color,
      this.border = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
//    if (path == "") {
//      imageWidget = Image.asset(
//        ImageConstants.ic_logo_borderless,
//        width: width,
//        height: height,
//        fit: fit,
//      );
//    } else
    if (file != null) {
      imageWidget = Image.file(
        file,
        width: width,
        height: height,
        fit: fit,
      );
    }
//      else if(path==null){
//      imageWidget = FadeInImage.assetNetwork(
//          image: "",
//          width: width,
//          height: height,
//          fadeInDuration: const Duration(milliseconds: 1),
//          fit: fit,
//          placeholder: ImageConstants.ic_logo_borderless);
//    }

    else if (path?.startsWith('assets/') ?? false) {
      imageWidget = Image.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        color: color,
      );
    }
    else if (path?.startsWith('data') ?? false) {
      imageWidget = Image.memory(
          base64Decode(path.substring(path.indexOf(",")+1,path.length)), width: width,
          height: height,
          fit: fit,
      );
    }
    else if (path?.startsWith('http') ?? false) {
      imageWidget = FadeInImage.assetNetwork(
          image: path,
          width: width,
          height: height,
          fadeInDuration: const Duration(milliseconds: 1),
          fit: fit,
          placeholder: Assets.logo);
    }
    else {
      imageWidget = Container(
        child: Image.file(
          File(path),
          width: width,
          height: height,
          fit: fit,
        ),
      );
    }
    return circleCrop
        ? CircularProfileAvatar(
            (path != null && path.startsWith('http')) ? path : "",
            child: imageWidget,
            //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
            radius: radius,
            // sets radius, default 50.0
            backgroundColor: Colors.white,
            // sets background color, default Colors.white
            borderWidth: border,
            // sets border, default 0.0
            initialsText: Text(
              "AD",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            // sets initials text, set your own style, default Text('')
            borderColor: AppColors.primaryColor,

            cacheImage: true,
          )
        : imageWidget;
  }
}
