import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  final bool full;

  const CustomProgressIndicatorWidget({
    Key key,this.full
  }) : super(key: key);




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
            height: 100,
            width: 100,
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
          padding: const EdgeInsets.all(25.0),
          child: CircularProgressIndicator(),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
