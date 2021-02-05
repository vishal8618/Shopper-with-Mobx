import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/font_family.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';

class CreditCard extends StatefulWidget {
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  CreditCardModel creditCardModel;

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  CardType _cardType;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ScreenScaler _scaler;

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return Scaffold(
      appBar: AppBar(actions: [IconButton(icon: Icon(Icons.check), onPressed: (){
        if (formKey.currentState.validate()) {
          Navigator.of(context).pop(creditCardModel);
        }
      })],),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardForm(
                    formKey: formKey,
                    obscureCvv: true,
                    obscureNumber: true,
                    cardNumberDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                    ),
                    expiryDateDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Expired Date',
                      hintText: 'MM/YY',
                    ),
                    cvvCodeDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CVV',
                      hintText: 'XXX',
                    ),
                    cardHolderDecoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    this.creditCardModel=creditCardModel;
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;

      var type=detectCCType(cardNumber);


      if(type==CreditCardType.discover)
        _cardType=CardType.discover;
      else if(type==CreditCardType.mastercard)
        _cardType=CardType.mastercard;
      else if(type==CreditCardType.visa)
        _cardType=CardType.visa;
      else if(type==CreditCardType.amex)
        _cardType=CardType.americanExpress;
      else
        _cardType=null;




    });
  }
}
