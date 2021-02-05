import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/data/network/constants/constants.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';
import 'package:google_maps_webservice/places.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  ScreenScaler _scaler;
  var controllersList = List<TextEditingController>();

  @override
  void initState() {
    controllersList.add(TextEditingController());
    controllersList.add(TextEditingController());
    controllersList.add(TextEditingController());
    controllersList.add(TextEditingController());
    controllersList.add(TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _scaler = ScreenScaler()..init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: ListView(
        padding: _scaler.getPadding(1, 4),
        children: [
          GestureDetector(
            onTap: () {
              openSuggestions();
            },
            child: AppTextField(
              hintText: 'Address line 1',
              controller: controllersList[0],
              editabled: false,
            ),
          ),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(
              hintText: 'Address line 2', controller: controllersList[1]),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(hintText: 'State', controller: controllersList[2]),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(hintText: 'City', controller: controllersList[3]),
          SizedBox(
            height: _scaler.getHeight(2),
          ),
          AppTextField(hintText: 'ZipCode', controller: controllersList[4]),
        ],
      ),
    );
  }

  openSuggestions() async {
    Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: Constants.googleApiKey,
        mode: Mode.overlay, // Mode.fullscreen

        components: [
          Component(Component.postalCode, "37341"),
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
          Component(Component.postalCode, "37424"),
        ]);
  }
}
