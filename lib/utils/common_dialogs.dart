import 'package:flutter/cupertino.dart';
import 'package:greetings_world_shopper/widgets/login_dialog.dart';
import 'package:greetings_world_shopper/widgets/report_dialog.dart';
import 'package:material_dialog/widgets/dialog.dart';

import '../routes.dart';

class CommonDialogs {
  static showLoginDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => LoginDialog(
              yesClick: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(Routes.login);
              },
            ));
  }

  static showReportDialog(context, Function(String) callback) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => ReportDialog(callback: callback));
  }
}
