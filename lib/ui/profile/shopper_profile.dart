import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/polygon_clipper/polygon_clipper.dart';
import 'package:greetings_world_shopper/widgets/shape_of_view/shape/arc.dart';
import 'package:greetings_world_shopper/widgets/shape_of_view/shape_of_view.dart';
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
      body: Material(
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              children: [_buildHeader(), Expanded(child: _buildBody())],
            ),
          ],
        ),
      ),
      /* backgroundColor: Colors.white,
      body: _buildBody(),*/
    );
  }

  Widget _buildHeader() {
    return Container(
      height: _scaler.getHeight(22),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: ShapeOfView(
              elevation: 4,
              bgColor: AppColors.primaryColor,
              shape: ArcShape(
                height: _scaler.getHeight(5),
                position: ArcPosition.Bottom,
                direction: ArcDirection.Outside,
              ),
              height: _scaler.getHeight(14),
              child: Stack(
                children: [
                  Container(
                    decoration:
                        BoxDecoration(gradient: AppColors.primaryGradient),
                  ),
                ],
              ),
              /*    child: Stack(
              */ /* children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: AppColors.transParentGradient,
                      ),
                  ),
                  Container(
                    decoration:
                    BoxDecoration(gradient: AppColors.primaryGradient),
                  ),
                ],*/ /*
              ),*/
            ),
          ),
          Center(
            child: Container(
              width: _scaler.getHeight(12),
              height: _scaler.getHeight(12),
              margin: _scaler.getMarginLTRB(0, 6, 0, 0),
              child: ClipPolygon(
                sides: 6,
                borderRadius: 5.0,
                child: Container(
                    height: 12,
                    width: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: AppColors.transParentGradient,
                        image: DecorationImage(
                            image: _userStore.image != null
                                ? FileImage(_userStore.image)
                                : NetworkImage(
                                _userStore.userImage),
                            fit: BoxFit.contain))


                ),
                  ),

              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: _scaler.getWidth(100),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //_getImage(),
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
      width: _scaler.getWidth(32),
      height: _scaler.getWidth(32),
      child: CircleAvatar(
        radius: 50,
        child: ImageView(
          path: Assets.user,
          radius: 100,
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: Colors.purple,
          width: 4.0,
        ),
      ),
    );
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
            SizedBox(
              height: _scaler.getHeight(2),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.shopperProfileDetail);
              },
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
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
            ),
            SizedBox(
              height: _scaler.getHeight(2),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(Routes.creditCard);
              },
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
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
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: _scaler.getHeight(2),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.completeAddress , arguments: 'shopperProfile');
              },
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
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
            SizedBox(
              height: _scaler.getHeight(2),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context).pushNamed(Routes.completeAddress);
              },
              child: Container(
                margin:
                    EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 0),
                padding: _scaler.getPadding(2, 3),
                alignment: Alignment.center,
                width: _scaler.getWidth(35),
                height: _scaler.getWidth(25),
                decoration: getDecoration(),
                child: AppText(
                  text: "Terms and Agreements",
                  style: AppTextStyle.medium,
                  align: true,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  BoxDecoration getDecoration() {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: _scaler.getBorderRadiusCircular(10.0));
  }
}
