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
import 'package:greetings_world_shopper/ui/home/bloc.dart';
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
  bool showVerifiedText = false;
  Repository _repository;
  UserStore _userStore;
  CartStore _cartStore;
  DeepLinkBloc _bloc;
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
    _bloc = Provider.of<DeepLinkBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_scaler == null) _scaler = ScreenScaler()..init(context);

    return StreamBuilder<String>(
        stream: _bloc.state,
        builder: (context,  snapshot) {
          print('SS Data========> ${snapshot.data}');
          if (snapshot.hasData) {
            showVerifiedText = true;
            final splitInviteLink = snapshot.data.split('?');
            final inviteToken = splitInviteLink[splitInviteLink.length - 1];
            print('tokennnn====>$inviteToken');

            if (!_userStore.loading)
             if(!hitVerifyApi){
               hitVerifyApi = true;
               _userStore.userConfirmation(token: inviteToken);
               if (Navigator.of(context).canPop()) Navigator.pop(context);
             }
          } else {
            showVerifiedText = false;
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: AppText(
                text: Strings.login,
                color: Colors.white,
                style: AppTextStyle.medium,
              ),
              centerTitle: true,
              actions: [
                !Navigator.of(context).canPop()
                    ? Center(
                        child: GestureDetector(
                          onTap: () {
                         /*   Navigator.of(context)
                                .pushReplacementNamed(Routes.home);*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AppText(
                              text: "",
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
            body: GestureDetector(
                onTap: () {
                  DeviceUtils.hideKeyboard(context);
                },
                child: Container(color: Colors.purple, child: _buildBody())),
          );
        });
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
              showVerifiedText ? _buildText(context) : Container(),
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
              SizedBox(
                height: _scaler.getHeight(3),
              ),
            ],
          ),
          _handleErrorMessage(),
          _userStore.loading ? CustomProgressIndicatorWidget() : Container(),
        ],
      );
    });
  }

  Widget _handleErrorMessage() {
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

  Widget _buildText(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(
          text: Strings.thankyou_Messsage,
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10.5),
          color: Colors.white,
        )
      ],
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}
