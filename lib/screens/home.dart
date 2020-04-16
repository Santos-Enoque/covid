import 'package:covid/helpers/style.dart';
import 'package:covid/providers/auth.dart';
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
    final auth = Provider.of<AuthProvider>(context);

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
            FlatButton(onPressed: (){
              auth.signOut();
            }, child: Text("LogOUt"))
          ],
        ),
      ),
    );
  }
}