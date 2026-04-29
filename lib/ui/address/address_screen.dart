import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/data/network/constants/constants.dart';
import 'package:greetings_world_shopper/models/placeDetail/place_service.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/utils/error_bar.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:greetings_world_shopper/widgets/progress_indicator_widget.dart';
import 'package:provider/provider.dart';

import '../../routes.dart';

class AddressScreen extends StatefulWidget {
  final String sendResult;

  AddressScreen({this.sendResult});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final formKey = GlobalKey<FormState>();
  ScreenScaler _scaler;
  bool initial;
  var controllersList = List<TextEditingController>();
  bool _status = true;
  UserStore _userStore;
  var address1Controller = TextEditingController();
  var address2Controller = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var zipController = TextEditingController();
  double longitude = 0.0;
  double latitude = 0.0;
  final FocusNode myFocusNode = FocusNode();
  bool onPressed = false;
  bool zipCodeCheck = false;
  String countryName;
  String selectedValue;
  final controller = ScrollController();
  var prefix = 'Kyiv, ';

  String address = '';

  @override
  void initState() {
    super.initState();
    initial = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_userStore.address1.trim().compareTo("null") == 0 ||
          _userStore.address1 == null) {
        address1Controller.text = "";
      } else {
        address1Controller.text = _userStore.address1;
      }
      if (_userStore.userCity.trim().compareTo("null") == 0 ||
          _userStore.userCity == null) {
        cityController.text = "";
      } else {
        cityController.text = _userStore.userCity;
      }

      if (_userStore.userZip.trim().compareTo("null") == 0 ||
          _userStore.userZip == null) {
        zipController.text = "";
      } else {
        zipController.text = _userStore.userZip;
      }

      setState(() {
        zipCodeCheck = zipController.text.isEmpty;
      });

      print('Address=====>${_userStore.address1}  pp');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    initial = false;
  }

  @override
  Widget build(BuildContext context) {
    Routes.context = context;
    _scaler = ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          Observer(builder: (snapshot) {
            return _userStore.isEditing
                ? Container(
                    width: 50,
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
                      });
                    },
                  );
          })
        ],
      ),
      body: _buildBody(),
    );
    /* return WillPopScope(
      child: Observer(builder: (context) {

      }),
      onWillPop: pop,
    );*/
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
              padding: _scaler.getPadding(1, 4),
              children: [
                Form(
                    key: formKey,
                    child: Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: !_userStore.isEditing
                                ? null
                                : () {
                              print("Prediction Data: ===> 0");
                                    DeviceUtils.hideKeyboard(context);
                                    openSuggestions();
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);


                                  },
                            child: AppTextField(
                              hintText: 'Address line 1',
                              controller: address1Controller,
                              maxLines: null,
                              editabled: false,
                              validate: (value) => value == null
                                  ? 'Please select address'
                                  : null,


                            ),
                          ),
                          /*    SizedBox(
                            height: _scaler.getHeight(2),
                          ),
                          AppTextField(
                            hintText: 'State',
                            controller: stateController,
                            editabled: false,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please fill address1';
                              }
                              return null;
                            },
                          ),*/
                          SizedBox(
                            height: _scaler.getHeight(2),
                          ),
                          AppTextField(
                            hintText: 'City',
                            controller: cityController,
                            validate: (value) {
                              if (value.isEmpty ||
                                  value == null ||
                                  value == '') {
                                return 'Please fill city';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: _scaler.getHeight(2),
                          ),
                          zipCodeCheck
                              ? Container(
                                  padding: _scaler.getPadding(0.5, 1),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                    dropdownColor: Colors.white,
                                    style: AppTextField.textMedium(
                                        AppColors.textColorDark,
                                        _scaler.getTextSize(10)),
                                    items: getZipList(),
                                    isExpanded: false,
                                    isDense: true,
                                    onChanged: (value) {
                                      setState(() {
                                        DeviceUtils.hideKeyboard(context);
                                        selectedValue = value;
                                      });
                                    },
                                    hint: Text('Select Zip Code'),
                                    validator: (value) => value == null
                                        ? 'Please select zip code'
                                        : null,
                                    value: selectedValue,
                                  )),
                                )
                              : AppTextField(
                                  hintText: 'ZipCode',
                                  controller: zipController,
                                  editabled: false,
                                  validate: (text) {
                                    if (text.isEmpty) {
                                      return 'Please fill zipCode';
                                    }
                                    return null;
                                  },
                                ),
                          !_status ? _getActionButtons() : new Container(),
                        ],
                      ),
                    )),
              ],
            ),
            _handleErrorMessage(),
            _userStore.loading ? CustomProgressIndicatorWidget() : Container(),
          ],
        );
      }),
    );
  }

  openSuggestions() async {
    print("Prediction Data: ===> 1");
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.googleApiKey,
        mode: Mode.overlay,
        // Mode.fullscreen
        language: "en",
        components: [
          new Component(Component.country, "us"),
        ]);
    print("Prediction Data: 2===>  $p");
    print("Prediction Data: $mounted, ${p.placeId}");
    getPlaceDetails(p);
  }


  /*void getPlaceDetails(Prediction prediction) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces(
        apiKey: Constants.googleApiKey); //Same API_KEY as above
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(prediction.placeId);
    latitude = detail.result.geometry.location.lat;
    longitude = detail.result.geometry.location.lng;
    address1Controller.text = prediction.description;
    try {
      await Geolocator()
          .placemarkFromCoordinates(latitude, longitude)
          .then((result) {
        Placemark placeMark = result[0];
        String name = placeMark.name;
        String subLocality = placeMark.subLocality;
        cityController.text = placeMark.locality;
        stateController.text = placeMark.administrativeArea;
        zipController.text = placeMark.postalCode;
        countryName = placeMark.country;

        print('ZIPCODE ==> ${placeMark.postalCode} - $zipCodeCheck');
        setState(() {
          if (placeMark.postalCode != null && placeMark.postalCode.isNotEmpty)
            zipCodeCheck = true;
          else
            zipCodeCheck = false;
        });
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }*/


  void getPlaceDetails(Prediction prediction) async {
    print("Location Data: $mounted, ${prediction.placeId}");
    final placeDetails =
        await PlaceApiProvider().getPlaceDetailFromId(prediction.placeId);
    if (mounted) {
      print('<=== ${placeDetails.streetNumber} - ${placeDetails.street}');

      address1Controller.text =
          "${placeDetails.streetNumber == null ? "" : placeDetails.streetNumber}  "
          "${placeDetails.street == null ? "" : placeDetails.street}";
       stateController.text = placeDetails.administrativeArea;
       cityController.text = placeDetails.city;
       print('City==========>${placeDetails.city}');
      print('zipCode==========>${placeDetails.zipCode}');
      zipController.text = placeDetails.zipCode;
      countryName = placeDetails.country;

      // setState(() {
      //   address1Controller.text = placeDetails.street;
      //   cityController.text = placeDetails.city;
      //   zipController.text = placeDetails.zipCode;
      // });


      address1Controller.text.trim().isEmpty
          ? zipCodeCheck = true
          : zipCodeCheck = false;

      setState(() {});
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
                  if(address1Controller.text.trim().isEmpty){
                    ErrorBar.showMessage("Please fill valid address", context);
                  }else{
                    setState(() {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (formKey.currentState.validate()) {
                        DeviceUtils.hideKeyboard(context);
                        _status = true;

                        _userStore.updateUserAddress(_userStore.uid,
                            street1: address1Controller.text.trim(),
                            street2: "",
                            city: cityController.text.trim(),
                            stateName: stateController.text.trim(),
                            countryName:
                            countryName == null || countryName.isEmpty
                                ? "USA"
                                : countryName,
                            zip: zipController.text == null ||
                                zipController.text.trim().isEmpty
                                ? selectedValue
                                : zipController.text.trim(),
                            lat: latitude.toString().trim(),
                            lng: longitude.toString().trim());
                      }
                    });
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
      if (widget.sendResult.compareTo('checkout') == 0) {
        Navigator.of(context).popAndPushNamed(Routes.checkout).then((value) {
          if (mounted) setState(() {});
        });
      } else if (widget.sendResult.compareTo('addressDialog') == 0) {
        Navigator.of(context).popAndPushNamed(Routes.checkout).then((value) {
          if (mounted) setState(() {});
        });
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home, (Route<dynamic> route) => false);
      }
    });

    return Container();
  }

  @override
  void dispose() {
    myFocusNode.dispose();

    // Clean up the controller when the Widget is disposed
    if (_userStore.isEditing) _userStore.updateIsEditing();

    super.dispose();
  }

  List<DropdownMenuItem<String>> getZipList() {
    List<DropdownMenuItem<String>> items = List();

    items.add(DropdownMenuItem(
        value: "37341",
        child: AppText(
          text: "37341",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37363",
        child: AppText(
          text: "37363",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37404",
        child: AppText(
          text: "37404",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37408",
        child: AppText(
          text: "37408",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37412",
        child: AppText(
          text: "37412",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37419",
        child: AppText(
          text: "37419",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37450",
        child: AppText(
          text: "37450",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37343",
        child: AppText(
          text: "37343",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37401",
        child: AppText(
          text: "37401",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37405",
        child: AppText(
          text: "37405",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37409",
        child: AppText(
          text: "37409",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37414",
        child: AppText(
          text: "37414",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37421",
        child: AppText(
          text: "37421",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37350",
        child: AppText(
          text: "37350",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37402",
        child: AppText(
          text: "37402",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37406",
        child: AppText(
          text: "37406",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37410",
        child: AppText(
          text: "37410",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37415",
        child: AppText(
          text: "37415",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37422",
        child: AppText(
          text: "37422",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37351",
        child: AppText(
          text: "37351",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));
    items.add(DropdownMenuItem(
        value: "37403",
        child: AppText(
          text: "37403",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37407",
        child: AppText(
          text: "37407",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37411",
        child: AppText(
          text: "37411",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37416",
        child: AppText(
          text: "37416",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    items.add(DropdownMenuItem(
        value: "37424",
        child: AppText(
          text: "37424",
          style: AppTextStyle.medium,
          size: _scaler.getTextSize(10),
        )));

    return items;
  }

  Future<bool> pop() async {
    Navigator.of(context).pop();
  }
}
