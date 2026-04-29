import 'dart:async';

import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/data/network/constants/constants.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/success_bar.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';
// import 'package:stripe_payment/stripe_payment.dart';

import '../../routes.dart';

class CreditCardScreen extends StatefulWidget {
  final bool sendResult;

  CreditCardScreen({this.sendResult});

  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCardScreen> {
  CreditCardModel creditCardModel;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CardType _cardType;
  String stripeToken = "";
  var cardNumberController = TextEditingController();
  var expYearController = TextEditingController();
  var expMonthController = TextEditingController();
  var cvvCodeController = TextEditingController();
  var cardHolderController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ScreenScaler _scaler;
  bool initial;
  CartStore _cartStore;
  UserStore _userStore;
  bool cardCheck = true;

  bool canPayNow = true;

  @override
  initState() {
    super.initState();
    initial = true;
    StripePayment.setOptions(StripeOptions(
        publishableKey: Constants.stripeTestKey, androidPayMode: 'test'));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartStore = Provider.of<CartStore>(context);
    _userStore = Provider.of<UserStore>(context);

    initial = false;
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    if (_scaler == null) _scaler = new ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                if (canPayNow) {
                  setState(() {
                    cardCheck = true;
                    DeviceUtils.hideKeyboard(context);
                    if (formKey.currentState.validate()) {
                      //  Navigator.of(context).pop(creditCardModel);
                      DeviceUtils.hideKeyboard(context);
                      canPayNow = false;
                      token();
                    }
                  });
                }

                Timer(Duration(seconds: 3), () {

                  setState(() {

                  });

                });


              })
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        DeviceUtils.hideKeyboard(context);
      },
      child: Observer(builder: (context) {
        return Stack(
          children: [
            ListView(
              children: [
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  cardBgColor: AppColors.primaryColor,
                  obscureCardNumber: false,
                  cardType: _cardType,
                  obscureCardCvv: true,
                ),
                Container(
                  child: Column(
                    children: [
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumberController.text.trim(),
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDate: expMonthController.text.trim(),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'MM/YY',
                        ),
                        cvvCode: cvvCodeController.text.trim(),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderName: cardHolderController.text.trim(),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                    ],
                  ),
                )
              ],
            ),
            _handleErrorMessage(),
            _handleSuccessMessage(),
            _cartStore.createOrderLoading
                ? CustomProgressIndicatorWidget()
                : Container(),
          ],
        );
      }),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    this.creditCardModel = creditCardModel;
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;

      var type = detectCCType(cardNumber);

      if (type == CreditCardType.discover)
        _cardType = CardType.discover;
      else if (type == CreditCardType.mastercard)
        _cardType = CardType.mastercard;
      else if (type == CreditCardType.visa)
        _cardType = CardType.visa;
      else if (type == CreditCardType.amex)
        _cardType = CardType.americanExpress;
      else
        _cardType = null;
    });

    if (cardNumber.isNotEmpty &&
        expiryDate.isNotEmpty &&
        cardHolderName.isNotEmpty &&
        cvvCode.isNotEmpty) {
      print("==========>add check logical or directly  navigate to next page");
    }
  }

  void token() async {
    List<String> arr = expiryDate.split('/');
    int date = int.parse(arr[0]);
    int year = int.parse(arr[1]);
    print(date.toString() + " " + year.toString());
    print('============>Month$expiryDate');
    final testCard =
        CreditCard(number: cardNumber, expMonth: date, expYear: year);

    StripePayment.createTokenWithCard(testCard).then((token) {

      setState(() {
        canPayNow = true;
      });

      print(token.tokenId);
      print("carttotal===>${_cartStore.cartTotal.toString()} ");
      _cartStore.processPayment(
          uid: _userStore.uid,
          totalAmount: _cartStore.cartSubTotal.roundToDouble().toString(),
          subTotal: _cartStore.cartTotal.toString(),
          shippingAmount: _cartStore.shippingAmount.toString(),
          taxCharges: _cartStore.taxCharges.toString(),
          serviceCharges: _cartStore.convenienceFee.toString(),
          stripeToken: token.tokenId.toString());
    });
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        return _cartStore.errorStore.errorMessage.isNotEmpty
            ? ErrorBar.showMessage(_cartStore.errorStore.errorMessage, context)
            : _cartStore.successStore.successMessage.isNotEmpty
                ? navigate(context)
                : SizedBox.shrink();
      },
    );
  }

  Widget _handleSuccessMessage() {
    return Observer(
      builder: (context) {
        return _cartStore.successStore.successMessage.isNotEmpty
            ? SuccessBar.showMessage(
                _cartStore.successStore.successMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
      /* if (Navigator.of(context).canPop())
        Navigator.of(context).pop();
      else
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);*/
    });

    return Container();
  }

  Future<bool> pop() async {
    Navigator.of(context).pop();
  }
}
