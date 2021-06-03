import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/data/repository.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/password_store.dart';
import 'package:greetings_world_shopper/stores/success_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/ui/deep_link/bloc.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/dio/dio_error_util.dart';
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

class ResetPasswordScreen extends StatefulWidget {
  final String message;

  const ResetPasswordScreen({Key key, this.message}) : super(key: key);
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {



  ScreenScaler _scaler;
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool emailFocus = false;
  bool passwordFocus = false;
  bool confirmPasswordFocus = false;
  PasswordStore _passwordStore;
  CartStore _cartStore;
  bool hitVerifyApi = false;

  var autoValidateMode  = AutovalidateMode.disabled;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if(widget.message.isValid()){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SuccessBar.showMessage(
            widget.message, context);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _passwordStore = Provider.of<PasswordStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    if (_scaler == null) _scaler = ScreenScaler()..init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        centerTitle: true,
      ),
      body: GestureDetector(
          onTap: () {
            DeviceUtils.hideKeyboard(context);
          },
          child: Container(color: /*Colors.purple*/AppColors.primaryColor, child: _buildBody())),
    );
  }

  Widget _buildBody() {
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
              autovalidateMode: autoValidateMode,
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
                          hintText: Strings.token,
                          controller: emailController,
                          inputType: TextInputType.text,
                          prefix: Icon(
                            Icons.security_rounded,
                            color: emailFocus ? AppColors.bg : AppColors.bg,
                            size: _scaler.getTextSize(14),
                          ),
                          validate: (text) {
                            return text.isNotEmpty
                                ? null
                                : AppLocalizations.of(context)
                                .translate(Strings.tokenError);
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
                      SizedBox(
                        height: _scaler.getHeight(2),
                      ),
                      Focus(
                        onFocusChange: (has) {
                          if (mounted) {
                            setState(() {
                              this.confirmPasswordFocus = has;
                            });
                          }
                        },
                        child: LoginTextField(
                          hintText: Strings.confirmPassword,
                          controller: confirmPasswordController,
                          maxLines: 1,
                          password: true,
                          prefix: Icon(
                            Icons.vpn_key,
                            color:
                            confirmPasswordFocus ? AppColors.bg : AppColors.bg,
                            size: _scaler.getTextSize(14),
                          ),
                          validate: (value) {
                            if (value.trim().length < 6) {
                              return AppLocalizations.of(context)
                                  .translate(Strings.passwordError);
                            } else if(value.trim() != passwordController.text.trim()){
                              return AppLocalizations.of(context)
                                  .translate(Strings.confirmPasswordError);
                            }
                            else {
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
                    resetPassword();
                  }else{
                    setState(() {
                      autoValidateMode  = AutovalidateMode.always;
                    });
                  }
                },
                child: AppText(
                  text: Strings.proceed,
                  color: Colors.purple,
                ),
              ),
            ),
            SizedBox(
              height: _scaler.getHeight(3),
            ),
          ],
        ),
        _handleErrorMessage(),
        _handleSuccessMessage(),
        _passwordStore.loading || isLoading ? CustomProgressIndicatorWidget() : Container(),
      ],
    );
  }

  Widget _handleSuccessMessage() {
    return Observer(
      builder: (context) {
        return _passwordStore.resetSuccessStore.successMessage != null && _passwordStore.resetSuccessStore.successMessage.isNotEmpty
            ?  navigate(context, _passwordStore)
            : SizedBox.shrink();
      },
    );
  }

  Widget navigate(BuildContext context, PasswordStore passwordStore) {

    SuccessStore successStore = passwordStore.resetSuccessStore;

    SuccessBar.showMessage(
        successStore.successMessage, context);

    Future.delayed(Duration(seconds: 1), () {
      var success = _passwordStore.success;
      print('sucess = $success');
      // move reset password screen
      if(success){

      }
    });

    return Container();
  }

  @override
  void dispose() {
    super.dispose();
    _passwordStore.errorStore.dispose();
    _passwordStore.error = false;
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        return _passwordStore.error ? navigates(context) : SizedBox.shrink();
      },
    );
  }

  Widget navigates(BuildContext context) {
    print("userError=========>${_passwordStore.errorStore.errorMessage}");

    if (_passwordStore.resetErrorStore.errorMessage.isNotEmpty) {
      ErrorBar.showMessage(_passwordStore.resetErrorStore.errorMessage, context);
      _passwordStore.resetErrorStore.errorMessage = "";
    }

    return Container();
  }

  void resetPassword() {
    setState(() {
      isLoading = true;
    });
    final future = _passwordStore.getRepository().resetPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim()
    );

    future.then((value) {
      SuccessBar.showMessage(
          value.message, context);
      setState(() {
        isLoading = false;
      });
      if(value.status){
        Future.delayed(Duration(seconds: 1)).then((value) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
          });
        });
      }
    }).catchError((error) {
      var errorMessage = DioErrorUtil.handleError(error);
      ErrorBar.showMessage(errorMessage, context);
      setState(() {
        isLoading = false;
      });
    });


  }
}

extension Valid on String {
  bool isValid() => this != null && this.isNotEmpty;
}