import 'package:covid/helpers/style.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomText(
                text: "Corona Out",
                color: primary,
                size: 22,
                weight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SpinKitWave(
            color: primary,
            size: 30,
          )
        ],
      ),
    );
  }
}
