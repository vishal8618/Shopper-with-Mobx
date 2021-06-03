import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:greetings_world_shopper/utils/success_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/login_text_feild.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  ScreenScaler _scaler;
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool emailFocus = false;
  bool passwordFocus = false;
  Repository _repository;
  UserStore _userStore;
  CartStore _cartStore;
  bool hitVerifyApi = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    if (_scaler == null) _scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        /*title: AppText(
          text: Strings.login,
          color: Colors.white,
          style: AppTextStyle.medium,
        ),*/
        elevation: 0,
        centerTitle: true,
        actions: [
          !Navigator.of(context).canPop()
              ? Center(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Routes.home);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: Strings.tourApp,
                  style: AppTextStyle.title,
                  color: Colors.white,
                  underline: true,
                  size: _scaler.getTextSize(10),
                ),
              ),
            ),
          )
              : Container()
        ],
      ),
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   /*   title: AppText(
      //           text: Strings.login,
      //           color: Colors.white,
      //           style: AppTextStyle.medium,
      //         ),*/
      //   centerTitle: true,
      //   actions: [
      //     !Navigator.of(context).canPop()
      //         ? Center(
      //             child: GestureDetector(
      //               onTap: () {
      //                 /*   Navigator.of(context)
      //                           .pushReplacementNamed(Routes.home);*/
      //               },
      //               child: Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: AppText(
      //                   text: "",
      //                   style: AppTextStyle.title,
      //                   color: Colors.white,
      //                   underline: true,
      //                   size: _scaler.getTextSize(10),
      //                 ),
      //               ),
      //             ),
      //           )
      //         : Container()
      //   ],
      // ),
      body: GestureDetector(
          onTap: () {
            DeviceUtils.hideKeyboard(context);
          },
          child: Container(color: /*Colors.purple*/AppColors.primaryColor, child: _buildBody())),
    );
  }

  Widget _buildBody() {
    return Observer(builder: (context) {
      return Stack(
        children: [
          ListView(
            children: [
              ImageView(
                path: Assets.logo,
                height: _scaler.getHeight(25),
                width: _scaler.getWidth(30),
                color: AppColors.starYellow,
              ),
              Form(
                key: formKey,
                child: Container(
                  margin: _scaler.getPadding(1, 1),
                  child: Container(
                    padding: _scaler.getPadding(1, 1),
                    child: Column(
                      children: [
                        Focus(
                          onFocusChange: (has) {
                            if (mounted) {
                              setState(() {
                                this.emailFocus = has;
                              });
                            }
                          },
                          child: LoginTextField(
                            hintText: Strings.email,
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefix: Icon(
                              Icons.email,
                              color: emailFocus ? AppColors.bg : AppColors.bg,
                              size: _scaler.getTextSize(14),
                            ),
                            validate: (text) {
                              return isEmail(text)
                                  ? null
                                  : AppLocalizations.of(context)
                                      .translate(Strings.emailError);
                            },
                          ),
                        ),
                        SizedBox(
                          height: _scaler.getHeight(2),
                        ),
                        Focus(
                          onFocusChange: (has) {
                            if (mounted) {
                              setState(() {
                                this.passwordFocus = has;
                              });
                            }
                          },
                          child: LoginTextField(
                            hintText: Strings.password,
                            controller: passwordController,
                            maxLines: 1,
                            password: true,
                            prefix: Icon(
                              Icons.vpn_key,
                              color:
                                  passwordFocus ? AppColors.bg : AppColors.bg,
                              size: _scaler.getTextSize(14),
                            ),
                            validate: (value) {
                              if (value.trim().length < 6) {
                                return AppLocalizations.of(context)
                                    .translate(Strings.passwordError);
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: _scaler.getWidth(2,), bottom: _scaler.getWidth(2,),),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(Routes.forgotPassword,
                            arguments: Navigator.of(context).canPop())
                            .then((value) => () {
                          // if (mounted) {
                          //   setState(() {});
                          // }
                        });
                      },
                      child: AppText(
                        text: Strings.forgotPasswordQues,
                        style: AppTextStyle.title,
                        color: AppColors.bg,
                        size: _scaler.getTextSize(10),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: _scaler.getMargin(1, 3),
                child: MaterialButton(
                  height: _scaler.getHeight(3.5),
                  color: AppColors.bg,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      DeviceUtils.hideKeyboard(context);

                      _userStore.login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  },
                  child: AppText(
                    text: Strings.proceed,
                    color: Colors.purple,
                  ),
                ),
              ),
              SizedBox(
                height: _scaler.getHeight(2),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: Strings.dontHaveAccount,
                    style: AppTextStyle.regular,
                    color: AppColors.bg,
                    size: _scaler.getTextSize(10),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.signUp,
                              arguments: Navigator.of(context).canPop())
                          .then((value) => () {
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        text: Strings.registerNow,
                        style: AppTextStyle.title,
                        color: AppColors.bg,
                        size: _scaler.getTextSize(10),
                      ),
                    ),
                  )
                ],
              ),
              // if(!Navigator.of(context).canPop())
              //      Container(
              //        margin: EdgeInsets.only(top: _scaler.getHeight(0.5),),
              //   alignment: Alignment.center,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.of(context).pushReplacementNamed(Routes.home);
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: AppText(
              //         text: Strings.tourApp,
              //         style: AppTextStyle.title,
              //         color: Colors.white,
              //         underline: true,
              //         size: _scaler.getTextSize(10),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(
                height: _scaler.getHeight(3),
              ),
            ],
          ),
          _handleErrorMessage(),
          _handleSuccessMessage(),
          _userStore.loading ? CustomProgressIndicatorWidget() : Container(),
        ],
      );
    });
  }

  Widget _handleSuccessMessage() {
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
      _cartStore.getCart(uid: _userStore.uid);
      if (Navigator.of(context).canPop())
        Navigator.of(context).pop();
      else
        Navigator.of(context).pushReplacementNamed(Routes.home);
    });

    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    _userStore.errorStore.dispose();
    _userStore.error = false;
  }

  Widget _handleErrorMessage() {
    print("Error=========>${_userStore.errorStore.errorMessage}");
    return Observer(
      builder: (context) {
        return _userStore.error ? navigates(context) : SizedBox.shrink();
      },
    );
  }

  Widget navigates(BuildContext context) {
    print("userError=========>${_userStore.errorStore.errorMessage}");

    if (_userStore.errorStore.errorMessage.isNotEmpty) {
      ErrorBar.showMessage(_userStore.errorStore.errorMessage, context);
    }

    Future.delayed(Duration(milliseconds: 0), () {
      if (_userStore.errorStore.errorMessage
          .contains("Email or password is invalid")) {
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      } else if (_userStore.errorStore.errorMessage.contains(
          "Phone number not verified! Please verify your phone number.")) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Routes.verify, (route) => false);
      }else if(_userStore.errorStore.errorMessage.contains("Email not confirmed! Please check email and confirm.")){
        if (Navigator.of(context).canPop()) Navigator.of(context).pop();
      }

      /*if (Navigator.of(context).canPop())
        Navigator.of(context).pop();
      else
       Navigator.of(context).pushNamedAndRemoveUntil(Routes.verify, (route) => false);*/
    });

    return Container();
  }
}
