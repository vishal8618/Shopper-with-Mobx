import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/home_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/cart/cart.dart';
import 'package:greetings_world_shopper/ui/dashboard/dashboard.dart';
import 'package:greetings_world_shopper/ui/profile/shopper_profile.dart';
import 'package:greetings_world_shopper/ui/receipts/receipts.dart';
import 'package:greetings_world_shopper/utils/common_dialogs.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/nav_cart_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScreenScaler _scaler;
  HomeStore _homeStore;
  UserStore _userStore;
  CartStore _cartStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _homeStore = Provider.of<HomeStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    _userStore = Provider.of<UserStore>(context);
    if (_userStore.isLoggedIn) _cartStore.getCart(uid: _userStore.uid);
  }

  @override
  Widget build(BuildContext context) {
    if (_scaler == null) _scaler = ScreenScaler()..init(context);
    return Observer(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(
            Icons.photo_camera,
            color: AppColors.starYellow,
          ),
          title: ImageView(
            path: Assets.logo,
            color: AppColors.starYellow,
            width: _scaler.getWidth(14),
          ),
          actions: [
            NavCartButton(
              items: _cartStore.cartItems,
            )
          ],
        ),
        body: _homeStore.selectedTab == 0
            ? DashboardScreen()
            : _homeStore.selectedTab == 1
                ? ReceiptsScreen()
                : _userStore.isLoggedIn?ShopperProfile():Container(width: 0,),
        bottomNavigationBar: getBottomNavigation(),
      );
    });
  }

  Widget getBottomNavigation() {
    return Observer(
      builder: (context) {
        return BottomNavigationBar(
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _homeStore.selectedTab,
          selectedItemColor: AppColors.starYellow,
          onTap: (selected) {
            if(selected==2 && !_userStore.isLoggedIn)
            CommonDialogs.showLoginDialog(context);
            else
            _homeStore.selectTab(selected);
          },
          items: [
            getItem(Assets.home),
            // getItem(Assets.hashTag),
            getItem(Assets.reciepts),
            getItem(Assets.user),
          ],
        );
      },
    );
  }

  BottomNavigationBarItem getItem(String path) {
    return BottomNavigationBarItem(
        icon: ImageView(
          path: path,
          color: AppColors.deselectedIcon,
          width: _scaler.getWidth(4.7),
          height: _scaler.getWidth(4.7),
          fit: BoxFit.fitHeight,
        ),
        activeIcon: ImageView(
          path: path,
          color: AppColors.starYellow,
          width: _scaler.getWidth(6),
        ),
        label: "");
  }
}
