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

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  ScreenScaler _scaler;
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool emailFocus = false;
  bool passwordFocus = false;
  PasswordStore _passwordStore;
  bool hitVerifyApi = false;

  @override
  void initState() {
    super.initState();
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
        title: AppText(
          text: Strings.forgotPassword,
          color: Colors.white,
          style: AppTextStyle.medium,
        ),
        elevation: 0,
        centerTitle: true,
      ),

      body: GestureDetector(
          onTap: () {
            DeviceUtils.hideKeyboard(context);
          },
          child: Container(color: AppColors.primaryColor, child: _buildBody())),
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

                      _passwordStore.forgotPassword(
                        email: emailController.text,
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
                height: _scaler.getHeight(3),
              ),
            ],
          ),
          _handleErrorMessage(),
          _handleSuccessMessage(),
          _passwordStore.loading ? CustomProgressIndicatorWidget() : Container(),
        ],
      );
    });
  }

  Widget _handleSuccessMessage() {
    return Observer(
      builder: (context) {
        return _passwordStore.successStore.successMessage.isNotEmpty
            ?  navigate(context, _passwordStore)
                : SizedBox.shrink();
      },
    );
  }

  Widget navigate(BuildContext context, PasswordStore userStore, ) {
    SuccessStore successStore = userStore.successStore;

    Future.delayed(Duration(milliseconds: 0), () {
      var success = _passwordStore.success;
      print('sucess = $success');
      // move reset password screen
      if(success){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pushNamed(Routes.resetPassword, arguments: successStore.successMessage);
        });
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

    if (_passwordStore.errorStore.errorMessage.isNotEmpty) {
      ErrorBar.showMessage(_passwordStore.errorStore.errorMessage, context);
      _passwordStore.errorStore.errorMessage = "";
    }

    return Container();
  }
}
