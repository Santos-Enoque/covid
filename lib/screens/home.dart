import 'package:covid/helpers/style.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: CustomText(text: "Phone Auth"),
          centerTitle: true,
          elevation: 0.5,
        ),
        backgroundColor: white,
        body:Column(
          children: <Widget>[
            FlatButton(onPressed: (){}, child: Text("LogOUt"))
          ],
        ),
      ),
    );
  }
}