import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:greetings_world_shopper/widgets/app_text.dart';
import 'package:greetings_world_shopper/widgets/app_text_field.dart';

class CustomProgressDashboardLoaderWidget extends StatelessWidget {
  final bool full;

  const CustomProgressDashboardLoaderWidget({Key key, this.full}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child:full==null||full? Container(
        height: 100,
        constraints: BoxConstraints.expand(),
        child: FittedBox(
          fit: BoxFit.none,
          child: SizedBox(
            height: 150,
            width: 250,
            child: _loader(),
          ),
        ),
        decoration: BoxDecoration(
            color: Color.fromARGB(100, 105, 105, 105)),
      ):_loader(),
    );
  }

  Widget _loader(){
    return Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              AppText(
                text: "Welcome to our Hashtag Mall Shopping Center! Loading Merchant please wait…..",
                color: Colors.purple,

              )
            ],
          ),        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

}
