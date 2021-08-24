import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:greetings_world_shopper/utils/success_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/phone_text_field.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class PhoneVerifyScreen extends StatefulWidget {

  final String token;

  const PhoneVerifyScreen({Key key, this.token}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  ScreenScaler _scaler;
  final phoneFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  var otpController = TextEditingController();
  bool phoneFocus = false;
  bool otpFocus = false;
  UserStore _userStore;
  DeepLinkBloc _bloc;
  bool hitVerifyApi = false;
  bool showOtpWidget = false;
  bool showVerifiedText = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      verifyEmail();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _bloc = Provider.of<DeepLinkBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    if (_scaler == null) _scaler = ScreenScaler()..init(context);
    return Material(
      child: Container(
        padding: _scaler.getPadding(1, 1),
        decoration: BoxDecoration(gradient: AppColors.splashGradient),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            !showOtpWidget ? buildPhoneVerify(context) : Container(),
            showOtpWidget ? buildOtpVerify(context) : Container(),
          ],

        ),
      ),
    );
  }

  Widget buildPhoneVerify(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 175),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showVerifiedText ? _buildText(context) : Container(),
          Form(
              key: phoneFormKey,
              child: Container(
                padding: _scaler.getPadding(1, 1),
                child: Column(
                  children: [
                    SizedBox(
                      height: _scaler.getHeight(2),
                    ),
                    Focus(
                      onFocusChange: (has) {
                        setState(() {
                          this.phoneFocus = has;
                        });
                      },
                      child: PhoneTextField(
                        hintText: Strings.phoneNumber,
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        maxLength: 12,
                        prefix: Icon(
                          Icons.phone,
                          color: phoneFocus
                              ? Colors.purple
                              : AppColors.textColorDark,
                          size: _scaler.getTextSize(14),
                        ),
                        validate: (value) {
                          if (value.trim().length < 7) {
                            return AppLocalizations.of(context)
                                .translate(Strings.phoneError);
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            width: _scaler.getWidth(100),
            margin: _scaler.getMargin(1, 3),
            child: MaterialButton(
              height: _scaler.getHeight(3.5),
              padding: _scaler.getPadding(1, 2),
              color: AppColors.primaryColor,
              onPressed: () {
                if (phoneFormKey.currentState.validate()) {
                  DeviceUtils.hideKeyboard(context);
                  _userStore.getOtpCode(
                      uid: _userStore.uid,
                      phoneNumber: "\+1" + phoneController.text.trim());
                  if (mounted) {
                    setState(() {
                      showOtpWidget = true;
                    });
                  }
                }
              },
              child: AppText(
                text: "Send Code",
                color: Colors.white,
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(11),
              ),
            ),
          ),
          SizedBox(
            height: _scaler.getHeight(3),
          ),
          _handleErrorPhoneMessage(),
          _handleSuccessPhoneMessage()
        ],
      ),
    );
  }

  Widget buildOtpVerify(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 175),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: _scaler.getHeight(5),
          ),
          AppText(
            text: Strings.otpVerify,
            style: AppTextStyle.medium,
            size: _scaler.getTextSize(12),
            color: Colors.purple,
          ),
          SizedBox(
            height: _scaler.getHeight(1),
          ),
          AppText(
            text:
                "We sent your code to ${"\+1" + phoneController.text.trim()}",
            style: AppTextStyle.medium,
            size: _scaler.getTextSize(11),
            color: Colors.purple,
          ),
          buildTimer(),
          Form(
            key: otpFormKey,
            child: Container(
              padding: _scaler.getPadding(1, 1),
              child: Column(
                children: [
                  SizedBox(
                    height: _scaler.getHeight(2),
                  ),
                  Focus(
                    onFocusChange: (has) {
                      setState(() {
                        this.otpFocus = has;
                      });
                    },
                    child: PhoneTextField(
                      hintText: Strings.otpNumber,
                      controller: otpController,
                      inputType: TextInputType.number,
                      maxLength: 6,
                      prefix: Icon(
                        Icons.input_rounded,
                        color:
                            otpFocus ? Colors.purple : AppColors.textColorDark,
                        size: _scaler.getTextSize(14),
                      ),
                      validate: (value) {
                        if (value.trim().length < 6) {
                          return AppLocalizations.of(context)
                              .translate(Strings.otpError);
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: _scaler.getWidth(100),
            margin: _scaler.getMargin(1, 3),
            child: MaterialButton(
              height: _scaler.getHeight(3.5),
              padding: _scaler.getPadding(1, 2),
              color: AppColors.primaryColor,
              onPressed: () {
                if (otpFormKey.currentState.validate()) {
                  DeviceUtils.hideKeyboard(context);
                  _userStore.phoneVerify(
                      phoneNumber: "\+1" + phoneController.text.trim(),
                      otp: otpController.text.trim(),uid: _userStore.uid);

                  // Navigator.of(context).pushReplacementNamed(Routes.welcome);
                }
              },
              child: AppText(
                text: "Submit",
                color: Colors.white,
                style: AppTextStyle.medium,
                size: _scaler.getTextSize(11),
              ),
            ),
          ),
          SizedBox(
            height: _scaler.getHeight(3),
          ),
          _handleErrorOtpMessage(),
        //  _handleSuccessMessage(),
        ],
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: "This code will expired in ",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(11),
          color: Colors.purple,
        ),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 1000),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }

  Widget _buildText(context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: _scaler.getHeight(5),
          ),
          AppText(
            text: Strings.thankyou_Messsage,
            style: AppTextStyle.medium,
            size: _scaler.getTextSize(12),
            color: AppColors.primaryColor,
            align: true,
          ),
        ],
      ),
    );
  }

  Widget _handleSuccessPhoneMessage() {
    return Observer(
      builder: (context) {
        return _userStore.successStore.successMessage.isNotEmpty
            ? SuccessBar.showMessage(
            _userStore.successStore.successMessage, context)
            : SizedBox.shrink();
      },
    );
  }

  Widget _handleErrorPhoneMessage() {
    return Observer(
      builder: (context) {
        if (_userStore.errorStore.errorMessage.isNotEmpty) {
          return ErrorBar.showMessage(
              _userStore.errorStore.errorMessage, context);
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _handleErrorOtpMessage() {
    return Observer(
      builder: (context) {
        return _userStore.errorStore.errorMessage.isNotEmpty
            ? ErrorBar.showMessage(_userStore.errorStore.errorMessage, context)
            : _userStore.success
            ? navigate(context)
            : SizedBox.shrink();
      },
    );
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.welcome, (route) => false);
    }
     /* if (Navigator.of(context).canPop())
        Navigator.of(context).pop();
      else

    }*/);

    return Container();
  }

  void verifyEmail() {
    if (widget.token != null && widget.token.isNotEmpty) {
      showVerifiedText = true;
      if (!_userStore.loading) if (!hitVerifyApi) {
        hitVerifyApi = true;
       _userStore.userConfirmation(token: widget.token);
        if (Navigator.of(context).canPop()) Navigator.pop(context);
      }
    }else {
      showVerifiedText = false;
    }
    setState(() {
      
    });
  }

}
