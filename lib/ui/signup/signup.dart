import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/routes.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/common_dialogs.dart';
import 'package:greetings_world_shopper/utils/common_utils.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:greetings_world_shopper/widgets/image_picker_dialog.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';
import 'package:validators/sanitizers.dart';

class SignupScreen extends StatefulWidget {
  final bool sendResult;

  SignupScreen({this.sendResult});

  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  ScreenScaler scaler;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool emailFocus = false;
  bool passwordFocus = false;

  bool nameFocus = false;

  UserStore _userStore;
  CartStore _cartStore;

  // ImagePicker _imagePicker;

  bool initial;
  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  @override
  void initState() {
    super.initState();
    // _imagePicker = ImagePicker();
    initial = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    if (initial && _userStore.image != null) _userStore.image = null;
    initial = false;
  }

  @override
  Widget build(BuildContext context) {
    Routes.context=context;
    if (scaler == null) scaler = new ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: ImageView(
          path: Assets.logo,
          color: AppColors.starYellow,
          width: scaler.getWidth(14),
        ),
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
                Container(
                  alignment: Alignment.center,
                  padding: scaler.getPadding(1.4, 0),
                  color: Colors.white,
                  width: scaler.getWidth(100),
                  child: AppText(
                    text: Strings.accountSetup,
                    style: AppTextStyle.regular,
                    size: scaler.getTextSize(11),
                  ),
                ),
                Form(
                  key: formKey,
                  child: Container(
                    margin: scaler.getPadding(1, 1),
                    child: Card(
                      elevation: 0,
                      color: Colors.white,
                      child: Container(
                        padding: scaler.getPadding(1, 1),
                        child: Column(
                          children: [
                            Observer(builder: (context) {
                              return DottedBorder(
                                color: AppColors.primaryColor1,
                                strokeWidth: 1.2,
                                dashPattern: [8, 0, 4, 4],
                                radius: Radius.circular(12),
                                borderType: BorderType.Rect,
                                child: Container(
                                  width: scaler.getWidth(100),
                                  height: scaler.getHeight(20),
                                  decoration: _userStore.image != null
                                      ? BoxDecoration(
                                          gradient:
                                              AppColors.transParentGradient,
                                          image: DecorationImage(
                                              image:
                                                  FileImage(_userStore.image),
                                              fit: BoxFit.contain))
                                      : null,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          margin: scaler.getMargin(0.6, 1),
                                          padding: scaler.getPadding(1, 2),
                                          child: ImageView(
                                            path: Assets.upload,
                                            height: scaler.getWidth(5),
                                            width: scaler.getWidth(5),
                                            color: Colors.white,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.textColorLight,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  ImagePickerDialog(
                                                    cameraClick: () {
                                                      getImage(1);
                                                    },
                                                    galleryClick: () {
                                                      getImage(2);
                                                    },
                                                    cancelClick: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ));
                                        },
                                      ),
                                      AppText(
                                        text: Strings.uploadPhoto,
                                        style: AppTextStyle.regular,
                                        color: AppColors.textColorLight,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                            SizedBox(
                              height: scaler.getHeight(3),
                            ),
                            Focus(
                              onFocusChange: (has) {
                                setState(() {
                                  this.nameFocus = has;
                                });
                              },
                              child: AppTextField(
                                hintText: Strings.fullName,
                                controller: nameController,
                                inputType: TextInputType.name,

                                prefix: Icon(
                                  Icons.account_circle,
                                  color: nameFocus
                                      ? AppColors.primaryColor1
                                      : AppColors.textColorDark,
                                  size: scaler.getTextSize(14),
                                ),
                                validate: (text) {
                                  return text != null && text != ""
                                      ? null
                                      : AppLocalizations.of(context)
                                          .translate(Strings.nameError);
                                },
                              ),
                            ),
                            SizedBox(
                              height: scaler.getHeight(2),
                            ),
                            Focus(
                              onFocusChange: (has) {
                                setState(() {
                                  this.emailFocus = has;
                                });
                              },
                              child: AppTextField(
                                hintText: Strings.email,
                                controller: emailController,

                                inputType: TextInputType.emailAddress,
                                prefix: Icon(
                                  Icons.email,
                                  color: emailFocus
                                      ? AppColors.primaryColor1
                                      : AppColors.textColorDark,
                                  size: scaler.getTextSize(14),
                                ),

                                validate: (text) {
                                  RegExp regex = new RegExp(pattern);
                                  if (text.trim().isEmpty) {
                                    return AppLocalizations.of(context)
                                        .translate(Strings.emailError);
                                  } else if (!(text.contains(regex))){
                                    return "Invalid Email";

                                  } else {
                                    return null;
                                  }
                                  /* return isEmail(text)
                                      ? null
                                      : AppLocalizations.of(context)
                                          .translate(Strings.emailError);*/
                                },
                              ),
                            ),
                      /*      SizedBox(
                              height: scaler.getHeight(2),
                            ),
                            Focus(
                              onFocusChange: (has) {
                                setState(() {
                                  this.phoneFocus = has;
                                });
                              },
                              child: AppTextField(
                                hintText: Strings.phoneNumber,
                                controller: phoneController,
                                inputType: TextInputType.phone,
                                maxLength: 12,
                                prefix: Icon(
                                  Icons.phone,
                                  color: phoneFocus
                                      ? AppColors.primaryColor1
                                      : AppColors.textColorDark,
                                  size: scaler.getTextSize(14),
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
                            ),*/
                            SizedBox(
                              height: scaler.getHeight(2),
                            ),
                            Focus(
                              onFocusChange: (has) {
                                setState(() {
                                  this.passwordFocus = has;
                                });
                              },
                              child: AppTextField(
                                hintText: Strings.password,
                                controller: passwordController,
                                maxLines: 1,
                                prefix: Icon(
                                  Icons.vpn_key_sharp,
                                  color: passwordFocus
                                      ? AppColors.primaryColor1
                                      : AppColors.textColorDark,
                                  size: scaler.getTextSize(14),
                                ),
                                password: true,
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
                ),
                Container(
                  margin: scaler.getMargin(1, 3),
                  child: MaterialButton(
                    height: scaler.getHeight(3.5),
                    color: AppColors.buttonBg,
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        DeviceUtils.hideKeyboard(context);

                        _userStore.signUp(
                          password: passwordController.text,
                          fullName: nameController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    child: AppText(
                      text: Strings.proceed,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            _handleErrorMessage(),
            _userStore.loading ? CustomProgressIndicatorWidget() : Container(),
          ],
        );
      }),
    );
  }

  Future getImage(int type) async {
    Navigator.of(context).pop();
    if (type == 1) {
      var image = await ImagePicker().getImage(source: ImageSource.camera);
      var img = await CommonUtils.getCroppedImage(File(image.path));
      _userStore.updateImage(img);
    } else {
      var image = await ImagePicker().getImage(source: ImageSource.gallery);
      var img = await CommonUtils.getCroppedImage(File(image.path));
      _userStore.updateImage(img);
    }
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
    Future.delayed(Duration(milliseconds: 100), () {
      _cartStore.getCart(uid: _userStore.uid);
      CommonDialogs.showConfirmationDialog(context);
     /* if (widget.sendResult) {
        Navigator.of(context).pop();
      } else
       */
    //  Navigator.of(context).pushReplacementNamed(Routes.login);

      /*  Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.login, (Route<dynamic> route) => false);*/
    });

    return Container();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
