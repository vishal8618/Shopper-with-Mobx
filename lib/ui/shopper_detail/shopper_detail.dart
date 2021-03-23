import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/assets.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/stores/cart_store.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/common_utils.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/utils/locale/app_localization.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:greetings_world_shopper/widgets/image_picker_dialog.dart';
import 'package:greetings_world_shopper/widgets/image_view.dart';
import 'package:greetings_world_shopper/widgets/polygon_clipper/polygon_clipper.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../../routes.dart';

class ShopperProfileDetail extends StatefulWidget {
  final bool sendResult;

  ShopperProfileDetail({this.sendResult});

  ShopperProfileDetailState createState() => ShopperProfileDetailState();
}

class ShopperProfileDetailState extends State<ShopperProfileDetail> {
  final formKey = GlobalKey<FormState>();
  final FocusNode myFocusNode = FocusNode();

  ScreenScaler scaler;
  bool _status = true;
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  bool isEnabled = true;

  bool emailFocus = false;
  bool phoneFocus = false;
  bool nameFocus = false;

  UserStore _userStore;
  CartStore _cartStore;

  // ImagePicker _imagePicker;

  bool initial;

  @override
  void initState() {
    super.initState();
    // _imagePicker = ImagePicker();
    initial = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      nameController.text = _userStore.name;
      phoneController.text = _userStore.phoneNumber;
      if (initial && _userStore.image != null) _userStore.image = null;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _cartStore = Provider.of<CartStore>(context);
    emailController.text = _userStore.userEmail;
    initial = false;
    print('======>${_userStore.userEmail}');
  }

  @override
  Widget build(BuildContext context) {
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
        actions: <Widget>[
          Observer(builder: (snapshot) {
            return _userStore.isEditing
                ? Container(
                    width: 0,
                  )
                : IconButton(
                    icon: Icon(
                      Icons.edit_outlined,
                      color: AppColors.starYellow,
                    ),
                    onPressed: () {
                      setState(() {
                        _userStore.updateIsEditing();
                        _status = false;
                        nameFocus = true;
                        phoneFocus = true;
                      });
                    },
                  );
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
                Form(
                  key: formKey,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: scaler.getPadding(1, 1),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                // backgroundColor: Colors.transparent,
                                radius: 70,
                                child: ClipOval(
                                  /*sides: 6,
                                    borderRadius: 5.0,*/ // Default 0.0 degrees
                                  child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          gradient:
                                              AppColors.transParentGradient,
                                          image: DecorationImage(
                                              image: _userStore.image != null
                                                  ? FileImage(_userStore.image)
                                                  : NetworkImage(
                                                      _userStore.userImage),
                                              fit: BoxFit.contain))),
                                ),
                                /*  child: Image.network(
                                    _userStore.userImage,

                                    fit: BoxFit.cover,
                                  ),*/
                              ),
                              Positioned(
                                  bottom: 1,
                                  right: 1,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: IconButton(
                                      icon: Icon(Icons.add_a_photo,
                                          color: Colors.white),
                                      onPressed: !_userStore.isEditing
                                          ? null
                                          : () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
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
                                    decoration: BoxDecoration(
                                        color: Colors.purpleAccent,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ))
                            ],
                          ),
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
                              controller: nameController,
                              hintText: Strings.fullName,
                              editabled: _userStore.isEditing,
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
                              editabled: false,
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
                                return isEmail(text)
                                    ? null
                                    : AppLocalizations.of(context)
                                        .translate(Strings.emailError);
                              },
                            ),
                          ),
                          SizedBox(
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
                              editabled: _userStore.isEditing,
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
                          ),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    ),
                  ),
                ),
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

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new AppText(
                  text: Strings.save,
                  color: Colors.white,
                  style: AppTextStyle.medium,
                ),
                textColor: Colors.white,
                color: AppColors.primaryColor,
                onPressed: () {

                    FocusScope.of(context).requestFocus(new FocusNode());
                    print("<====   ${formKey.currentState.validate()}");
                    if (nameController.text.trim().isEmpty) {
                      return "Invalid name";
                    } else if (phoneController.text.trim().isEmpty) {
                      return "Invalid phone";

                    } else if(phoneController.text.trim().length < 7){
                      return "phoneError";
                    }else {
                      _status = true;
                      DeviceUtils.hideKeyboard(context);
                      _userStore.updateUserDetails(_userStore.uid,
                          phone: phoneController.text.trim(),
                          fullName: nameController.text.trim());
                    }

                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new AppText(
                  text: Strings.cancel,
                  color: Colors.white,
                  style: AppTextStyle.medium,
                ),
                textColor: Colors.white,
                color: AppColors.primaryColor,
                onPressed: () {
                  _userStore.updateIsEditing();

                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
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
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    if (_userStore.isEditing) _userStore.updateIsEditing();
    _userStore.image= null;
    super.dispose();
  }
}
