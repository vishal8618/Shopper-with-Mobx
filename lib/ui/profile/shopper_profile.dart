import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:provider/provider.dart';

class ShopperProfile extends StatefulWidget {
  @override
  _ShopperProfileState createState() => _ShopperProfileState();
}

class _ShopperProfileState extends State<ShopperProfile> {
  UserStore _userStore;
  ScreenScaler _scaler;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      width: _scaler.getWidth(100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getImage(),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          _getStatus(),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          _getOptions()
        ],
      ),
    );
  }

  Widget _getImage() {
    return Container(
        width: _scaler.getWidth(40),
        height: _scaler.getWidth(40),
        child: ImageView(
          path: Assets.user,
        ));
  }

  Widget _getStatus() {
    return Container(
      padding: _scaler.getPadding(0.5, 2),
      decoration: getDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            text: "Active",
            style: AppTextStyle.medium,
            size: _scaler.getTextSize(11),
          ),
          SizedBox(
            width: _scaler.getWidth(0.3),
          ),
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: _scaler.getTextSize(11),
          )
        ],
      ),
    );
  }

  Widget _getOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: _scaler.getPadding(2, 3),
              alignment: Alignment.center,
              width: _scaler.getWidth(35),
              height: _scaler.getWidth(25),
              decoration: getDecoration(),
              child: AppText(
                text: "Shopper Details",
                style: AppTextStyle.medium,
                align: true,
              ),
            ),
            Container(
              padding: _scaler.getPadding(2, 3),
              alignment: Alignment.center,
              width: _scaler.getWidth(35),
              height: _scaler.getWidth(25),
              decoration: getDecoration(),
              child: AppText(
                text: "Bank Information",
                style: AppTextStyle.medium,
                align: true,
              ),
            ),
          ],
        ),
        SizedBox(
          height: _scaler.getHeight(2),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.completeAddress);
          },
          child: Container(
            padding: _scaler.getPadding(2, 3),
            alignment: Alignment.center,
            width: _scaler.getWidth(35),
            height: _scaler.getWidth(25),
            decoration: getDecoration(),
            child: AppText(
              text: "Shipping Information",
              style: AppTextStyle.medium,
              align: true,
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration getDecoration() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primaryColor, width: 1),
        borderRadius: _scaler.getBorderRadiusCircular(2));
  }
}
