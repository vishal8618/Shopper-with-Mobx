import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/models/cart/cart_item_model.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/checkout/checkout.dart';
import 'package:greetings_world_shopper/utils/common_dialogs.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/widgets/address_dialog.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:greetings_world_shopper/widgets/common_message_dialog.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/no_data_error.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartStore _cartStore;
  UserStore _userStore;
  ScreenScaler _scaler;
  bool initial;

  @override
  void initState() {
    super.initState();
    initial = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);

    if (!_cartStore.loading && initial && Routes.currentRoute == Routes.cart)
      _cartStore.getCart(uid: _userStore.uid);
    initial = false;
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    _scaler = ScreenScaler()..init(context);

    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            title: AppText(
              text: Strings.shoppingCart,
              style: AppTextStyle.medium,
              color: Colors.white,
            ),
            centerTitle: true,
          ),
          backgroundColor: AppColors.bg,
          body: Observer(builder: (context) {
            return Stack(
              children: [
                _buildItems(),
                _buildButtons(),
                _handleErrorMessage(),
                _cartStore.loading
                    ? CustomProgressIndicatorWidget()
                    : Container(),
              ],
            );
          }),
        ),
        onWillPop: pop);
  }

  Widget _buildItems() {
    return _cartStore.cartList != null && _cartStore.cartList.length > 0
        ? ListView(
            padding: _scaler.getPadding(1, 2),
            physics: BouncingScrollPhysics(),
            children: _cartStore.cartList.map((e) => getItem(e)).toList() +
                [
                  SizedBox(
                    height: _scaler.getHeight(16),
                  )
                ],
          )
        : !_cartStore.loading
            ? Positioned(
                top: 0,
                bottom: 0,
                left: _scaler.getWidth(20),
                right: _scaler.getWidth(20),
                child: NoDataError(
                  message: "Cart is empty!",
                ))
            : Container(
                width: _scaler.getWidth(0),
              );
  }

  Widget getItem(CartItemModel item) {
    return Container(
      margin: _scaler.getMarginLTRB(0, 0, 0, 1),
      decoration: BoxDecoration(
        borderRadius: _scaler.getBorderRadiusCircular(8),
        color: Colors.white,
      ),
      padding: _scaler.getPadding(1, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          ImageView(
            path: item.cartItem.product.productPhoto,
            fit: BoxFit.contain,
            color: AppColors.starYellow,
            width: _scaler.getWidth(22),
            height: _scaler.getWidth(22),
          ),
          SizedBox(
            width: _scaler.getWidth(1),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: item.cartItem.product.name,
                            color: AppColors.textColorDark,
                            style: AppTextStyle.medium,
                            size: _scaler.getTextSize(11),
                          ),
                          SizedBox(
                            height: _scaler.getHeight(0.3),
                          ),
                          AppText(
                            text:
                                "Price: \$${item.cartItem.product.price * item.cartItem.itemQuantity}",
                            color: AppColors.textColorDark,
                            style: AppTextStyle.medium,
                            size: _scaler.getTextSize(12.4),
                          ),
                          SizedBox(
                            height: _scaler.getHeight(0.3),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _cartStore.removeCart(
                            uid: _userStore.uid,
                            productId: item.cartItem.product.id.toString(),
                            quantity: item.cartItem.itemQuantity.toString());
                      },
                      child: Icon(
                        Icons.delete,
                        color: AppColors.textColorDark,
                        size: _scaler.getTextSize(15),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: _scaler.getPadding(0.1, 1),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.2))),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        dropdownColor: Colors.white,
                        style: AppTextField.textMedium(
                            AppColors.textColorDark, _scaler.getTextSize(10)),
                        items: getDeliveryType(item),
                        isExpanded: false,
                        isDense: true,
                        onChanged: (data) {
                          DeviceUtils.hideKeyboard(context);
                          if (item.cartItem.deliveryType != data)
                            _cartStore.updateDeliveryType(
                                buyerId: _userStore.uid,
                                id: item.cartItem.id.toString(),
                                deliveryType: data);
                        },
                        hint: Text('Select Type'),
                        value: item.cartItem.deliveryType,
                      )),
                    ),
                    Container(
                      padding: _scaler.getPadding(0.1, 1),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.grey.withOpacity(0.2))),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _cartStore.removeCart(
                                  uid: _userStore.uid,
                                  productId:
                                      item.cartItem.product.id.toString());
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.textColorDark,
                              size: _scaler.getTextSize(13),
                            ),
                          ),
                          Container(
                            padding: _scaler.getPadding(0, 1),
                            child:
                                AppText(text: "${item.cartItem.itemQuantity}"),
                          ),
                          GestureDetector(
                            onTap: () {
                              _cartStore.addCart(
                                  uid: _userStore.uid,
                                  productId:
                                      item.cartItem.product.id.toString());
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.textColorDark,
                              size: _scaler.getTextSize(13),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return _cartStore.cartList != null &&
            _cartStore.cartList.length > 0 &&
            !_cartStore.loading
        ? Positioned(
            bottom: _scaler.getHeight(2),
            left: 0,
            right: 0,
            child: Column(
              children: [
                SizedBox(
                  height: _scaler.getHeight(1),
                ),
                Container(
                  width: _scaler.getWidth(100),
                  margin: _scaler.getMargin(1, 3),
                  child: MaterialButton(
                    height: _scaler.getHeight(3.5),
                    padding: _scaler.getPadding(1, 0),
                    color: AppColors.buttonBg,
                    onPressed: () {
                      var temp = _cartStore.cartList;
                      if(_cartStore.cartList != null && _cartStore.cartList.isNotEmpty){
                        var data = _cartStore.cartList.firstWhere((element) => element.cartItem.deliveryType == null || element.cartItem.deliveryType.isEmpty, orElse: () => null);
                        if(data != null){
                          ErrorBar.showMessage("Please select delivery type of cart items", context, duration: Duration(seconds: 2));
                          return;
                        }
                      }

                      if (_userStore.address1.isEmpty ||
                          _userStore.address1.trim().compareTo("null") == 0 ||
                          _userStore.address1 == null) {
                        CommonDialogs.showAddressDialog(context);
                      } else {
                        Navigator.of(context)
                            .pushNamed(Routes.checkout)
                            .then((value) {
                          if (mounted) setState(() {});
                        });
                      }
                      /* if (_userStore.address1.trim().compareTo("null") == 0 || _userStore.address1 == null) {
                        showCodeInfoDialog();
                      } else {
                        Navigator.of(context)
                            .pushNamed(Routes.checkout)
                            .then((value) {
                          if(mounted) setState(() {});
                        });
                      }*/
                    },
                    child: AppText(
                      text: Strings.securePay,
                      color: Colors.white,
                      style: AppTextStyle.medium,
                      size: _scaler.getTextSize(11),
                    ),
                  ),
                ),
                Container(
                  width: _scaler.getWidth(100),
                  margin: _scaler.getMargin(0, 3),
                  child: MaterialButton(
                    height: _scaler.getHeight(3.5),
                    padding: _scaler.getPadding(1, 0),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                      width: 1,
                      color: AppColors.buttonBg,
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: AppText(
                      text: Strings.cancel,
                      color: AppColors.buttonBg,
                      style: AppTextStyle.medium,
                      size: _scaler.getTextSize(11),
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        return _cartStore.errorStore.errorMessage.isNotEmpty
            ? ErrorBar.showMessage(_cartStore.errorStore.errorMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  List<DropdownMenuItem<String>> getDeliveryType(CartItemModel cartItemModel) {
    List<DropdownMenuItem<String>> items = List();
    var data = cartItemModel.deliverTypes ?? [];

    if (data.isNotEmpty) {
      data.forEach((element) {
        items.add(DropdownMenuItem(
            value: element,
            child: AppText(
              text: element,
              style: AppTextStyle.medium,
              size: _scaler.getTextSize(10),
            )));
      });
    }
    return items;
  }

  Future<bool> pop() async {
    Navigator.of(context).pop();
  }
}
