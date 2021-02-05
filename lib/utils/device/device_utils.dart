//
import 'package:flutter/material.dart';

/// Helper class for device related operations.
///
class DeviceUtils {

  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }


}