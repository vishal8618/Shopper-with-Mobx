import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:greetings_world_shopper/constants/colors.dart';
import 'package:greetings_world_shopper/constants/strings.dart';
import 'package:greetings_world_shopper/data/network/constants/constants.dart';
import 'package:greetings_world_shopper/models/placeDetail/place_service.dart';
import 'package:greetings_world_shopper/stores/user_store.dart';
import 'package:greetings_world_shopper/utils/device/device_utils.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
  final FocusNode myFocusNode = FocusNode();
  bool onPressed = false;

  @override
  void initState() {
    super.initState();
    initial = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      address1Controller.text = _userStore.address1;
      address2Controller.text = _userStore.address2;
      stateController.text = _userStore.state;
      cityController.text = _userStore.city;
      zipController.text = _userStore.zip;
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
    _scaler = ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
                      });
                    },
                  );
          })
        ],
      ),
      body: ListView(
        padding: _scaler.getPadding(1, 4),
        children: [
          GestureDetector(
            onTap:!_userStore.isEditing ? null:
            () {
              DeviceUtils.hideKeyboard(context);
              openSuggestions();
            },
            child: AppTextField(
              hintText: 'Address line 1',
              controller: address1Controller,
              editabled: false,
              maxLines: null,
            ),
          ),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(
            hintText: 'Address line 2',
            controller: address2Controller,
            editabled: _userStore.isEditing,
          ),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(
              hintText: 'State', controller: stateController, editabled: false),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(
            hintText: 'City',
            controller: cityController,
            editabled: false,
          ),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(
            hintText: 'ZipCode',
            controller: zipController,
            editabled: false,
          ),
          !_status ? _getActionButtons() : new Container(),
        ],
      ),
    );
  }

  openSuggestions() async {
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.googleApiKey,
        mode: Mode.overlay,
        // Mode.fullscreen
        language: "en",
        components: [
          new Component(Component.country, "us"),
         /*  Component(Component.postalCode, "37341"),
          Component(Component.postalCode, "37363"),
          Component(Component.postalCode, "37404"),
          Component(Component.postalCode, "37408"),
          Component(Component.postalCode, "37412"),
          Component(Component.postalCode, "37419"),
          Component(Component.postalCode, "37450"),
          Component(Component.postalCode, "37343"),
          Component(Component.postalCode, "37401"),
          Component(Component.postalCode, "37405"),
          Component(Component.postalCode, "37409"),
          Component(Component.postalCode, "37414"),
          Component(Component.postalCode, "37421"),
          Component(Component.postalCode, "37350"),
          Component(Component.postalCode, "37402"),
          Component(Component.postalCode, "37406"),
          Component(Component.postalCode, "37410"),
          Component(Component.postalCode, "37415"),
          Component(Component.postalCode, "37422"),
          Component(Component.postalCode, "37351"),
          Component(Component.postalCode, "37403"),
          Component(Component.postalCode, "37407"),
          Component(Component.postalCode, "37411"),
          Component(Component.postalCode, "37416"),
          Component(Component.postalCode, "37424"),*/
        ]);
    getPlaceDetails(p);
  }

  void getPlaceDetails(Prediction prediction) async {
    final placeDetails =
        await PlaceApiProvider().getPlaceDetailFromId(prediction.placeId);
    setState(() {
      address1Controller.text = prediction.description;
      stateController.text = placeDetails.administrativeArea;
      cityController.text = placeDetails.city;
      zipController.text = placeDetails.zipCode;
    });
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
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _userStore.updateUserAddress(_userStore.uid,
                        street1: address1Controller.text,
                        street2: address2Controller.text,
                        city: cityController.text,
                        stateName: stateController.text,
                        zip: zipController.text);
                  });
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

  @override
  void dispose() {
    myFocusNode.dispose();

    // Clean up the controller when the Widget is disposed
    if (_userStore.isEditing) _userStore.updateIsEditing();
    super.dispose();
  }
}
