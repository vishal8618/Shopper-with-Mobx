import 'dart:io';

import 'package:flutter/material.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:image_cropper/image_cropper.dart';
 
class CommonUtils {
  static Future<File> getCroppedImage(File imageFile) async {
    var file = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop Image",
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: AppColors.primaryColor1,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    print(file.path);
    return file;
  }
}
