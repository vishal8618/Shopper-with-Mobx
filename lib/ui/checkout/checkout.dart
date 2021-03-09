import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/data/network/constants/constants.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/common_message_dialog.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

import 'package:stripe_payment/stripe_payment.dart';

import '../../routes.dart';

class CheckoutScreen extends StatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  ScreenScaler _scaler;
  CartStore _cartStore;
  UserStore _userStore;
  bool initial;
  @override
  void initState() {
    super.initState();
    print("===>initState");
    // _imagePicker = ImagePicker();
    initial = true;
   WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_cartStore.loading) _cartStore.getCart(uid: _userStore.uid);
    });

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    initial = false;
    print(
        "addressCheckout====>${_userStore.address1 + "," + _userStore.state + "," + _userStore.userCity + "," + _userStore.userZip}");
  }

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);
    return WillPopScope(
        child: Observer(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: AppText(
                text: Strings.checkoutSummary,
                style: AppTextStyle.medium,
                color: Colors.white,
              ),
              centerTitle: true,
            ),
            backgroundColor: AppColors.bg,
            body: Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    margin: _scaler.getMargin(1, 2),
                    child: Column(
                      children: [
                        Container(
                          padding: _scaler.getPadding(1, 2),
                          color: Colors.white,
                          child: Column(
                            children: [

                              _buildOwnInfo(),
                              _buildShopperInfo(),
                              _buildDetails()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _scaler.getHeight(16),
                        )
                      ],
                    ),
                  ),
                ),
                _buildButtons(),
                _handleErrorMessage(),
                _cartStore.loading
                    ? CustomProgressIndicatorWidget()
                    : Container(),
              ],
            ),
          );
        }),
        onWillPop: pop);
  }

  Widget _buildOwnInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: Strings.purchasedBy,
          style: AppTextStyle.regular,
        ),
        SizedBox(
          height: _scaler.getHeight(0.2),
        ),
        AppText(
          text: _userStore.name,
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(13),
        ),
        SizedBox(
          height: _scaler.getHeight(1),
        ),
        AppText(
          text: Strings.shippingAddress,
          style: AppTextStyle.regular,
        ),
        SizedBox(
          height: _scaler.getHeight(0.2),
        ),
        Container(
          padding: _scaler.getPaddingLTRB(0, 0, 12, 0),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  text: _userStore.address1 +
                      "," +
                      _userStore.state +
                      "," +
                      _userStore.userCity +
                      "," +
                      _userStore.userZip,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11.5),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.completeAddress,arguments: 'checkout');
                  })
            ],
          ),
        ),
      ],

    );

  }

  Widget _buildShopperInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                AppText(
                  text: Strings.specialCode,
                  style: AppTextStyle.medium,
                  size: _scaler.getTextSize(11.5),
                ),
                GestureDetector(
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: _scaler.getTextSize(10),
                    color: AppColors.primaryColor,
                  ),
                  onTap: () {
                    showCodeInfoDialog();
                  },
                )
              ],
            ),
            Container(
              padding: _scaler.getPadding(0.3, 2),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textColorLight),
              ),
              child: AppText(
                text: "54632",
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildDetails() {
    print("===>_buildDetails");
    return Column(
      children: [
        SizedBox(
          height: _scaler.getHeight(2),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: _scaler.getWidth(45),
              child: AppText(
                text: Strings.items,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: _scaler.getWidth(15),
              child: AppText(
                text: Strings.quantity,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: AppText(
                  text: Strings.cost,
                ),
              ),
            )
          ],
        ),
        Divider(
          height: _scaler.getHeight(2),
        ),
        Column(
          children: _cartStore.cartList
              .map((e) => getAmountCell(
                  e.cartItem.product.name,
                  e.cartItem.itemQuantity.toString(),
                  "\$${e.cartItem.product.price.toString()}"))
              .toList(),
        ),
        SizedBox(
          height: _scaler.getHeight(2),
        ),
        getAmountCell(
            Strings.subTotal, "", "\$${_cartStore.cartTotal.toString()}",
            bold: true),
        getAmountCell(Strings.taxes, "",
            "\$${_cartStore.taxCharges.toDouble().toStringAsFixed(2).trim()}"),
        getAmountCell(Strings.shipping, "",
            "\$${_cartStore.shippingAmount.toStringAsFixed(2).trim()}"),
        getAmountCell(Strings.convinceFee, "",
            "\$${_cartStore.convenienceFee.toDouble()}"),
        SizedBox(
          height: _scaler.getHeight(2),
        ),
        getAmountCell(Strings.yourTotal, "",
            "\$${_cartStore.cartSubTotal.toStringAsFixed(2).trim()}",
            bold: true),
        getAmountCell(
          Strings.estimatedDelivery,
          "",
          _cartStore.deliveryEstimated.toString(),
        ),
      ],
    );
  }

  Widget getAmountCell(String item, String quantity, String price,
      {bool bold}) {
    print("===>getAmountCell");

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              width: _scaler.getWidth(45),
              child: AppText(
                text: item,
                style:
                    bold == null ? AppTextStyle.regular : AppTextStyle.medium,
                size: _scaler.getTextSize(10.5),
              ),
            ),
            quantity == ""
                ? Container(
                    width: 0,
                  )
                : Container(
                    alignment: Alignment.center,
                    width: _scaler.getWidth(15),
                    child: AppText(
                      text: quantity,
                      style: bold == null
                          ? AppTextStyle.regular
                          : AppTextStyle.medium,
                      size: _scaler.getTextSize(10.5),
                    ),
                  ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: AppText(
                  text: price,
                  style:
                      bold == null ? AppTextStyle.regular : AppTextStyle.medium,
                  size: _scaler.getTextSize(10.5),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: _scaler.getHeight(0.5),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    return Positioned(
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
                 processPayment();
              //  Navigator.of(context).pushNamed(Routes.creditCard);
              },
              child: AppText(
                text: Strings.payNow,
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
    );
  }

  Widget _handleErrorMessage() {
    print("===>_handleErrorMessage");
    return Observer(
      builder: (context) {
        return _cartStore.errorStore.errorMessage.isNotEmpty
            ? ErrorBar.showMessage(_cartStore.errorStore.errorMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  showCodeInfoDialog() {
    print("===>showCodeInfoDialog");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CommonMessageDialog(
              message: Strings.specialCodeDesc,
              title: "",
            ));
  }

  processPayment() async {
    print("===>processPayment");

    // _cartStore.success=false;


    var result = await Navigator.of(context).pushNamed(Routes.creditCard);

    if (result != null && result is CreditCardModel) {
      // StripePayment.setOptions(
      //   StripeOptions(
      //     publishableKey: "pk_test_PqRugISQX9tprKeM08RG4WeQ00jq1t3ELU",
      //     androidPayMode: 'test',
      //   ),
      // );
      // await StripePayment.createTokenWithCard(CreditCard());
    }
  }

  Future<bool> pop() async {
    Navigator.of(context).pop();
  }


}
