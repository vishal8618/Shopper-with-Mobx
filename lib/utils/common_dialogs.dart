import 'package:flutter/cupertino.dart';
import 'package:greetings_world_shopper/stores/home_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/widgets/address_dialog.dart';
import 'package:greetings_world_shopper/widgets/confirmation_dialog.dart';
import 'package:greetings_world_shopper/widgets/login_dialog.dart';
import 'package:greetings_world_shopper/widgets/logout_dialog.dart';
import 'package:greetings_world_shopper/widgets/report_dialog.dart';
import 'package:material_dialog/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static showAddressDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => AddressDialog());
  }

  static showConfirmationDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => ConfirmationDialog(yesClick: () {
              Navigator.pop(context);
             // Navigator.of(context).pushNamed(Routes.login);
            }));
  }
  static showLogoutDialog(parentContext) {
    showDialog(
        context: parentContext,
        barrierDismissible: false,
        builder: (BuildContext context) => LogoutDialog(yesClick: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var isLoggedOut = await prefs?.clear();
          Provider.of<UserStore>(parentContext, listen: false).resetData();
          Provider.of<HomeStore>(context, listen: false).selectedTab = 0;
          if(isLoggedOut){
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (route) => false);
          }
        }));
  }


}
