import 'package:covid/helpers/screen_navigation.dart';
import 'package:covid/providers/bluetooth.dart';
import 'package:covid/screens/myapp.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    final blue = Provider.of<BlueToothProvider>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          FlatButton.icon(onPressed: (){
            changeScreen(context, Blue());
          }, icon: Icon(Icons.refresh), label: CustomText(text: "refresh"))
        ],
      ),
    );
  }
}