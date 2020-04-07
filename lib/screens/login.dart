import 'package:covid/helpers/style.dart';
import 'package:covid/providers/auth.dart';
import 'package:covid/widgets/custom_button.dart';
import 'package:covid/widgets/custom_text.dart';
import 'package:covid/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/cell.png",
              width: 160,
            ),
          ],
        ),
        SizedBox(height: 10),
        CustomText(text: "Corona Out", size: 28, weight: FontWeight.bold),
        SizedBox(height: 5),
        RichText(
            text: TextSpan(children: [
          TextSpan(text: "Welcome to the"),
          TextSpan(text: " Corona out", style: TextStyle(color: Colors.blue.shade900)),
          TextSpan(text: " app"),
        ], style: TextStyle(color: black))),
        SizedBox(height: 10),
        CustomTextField(
          hintText: "Ex: +123 345676",
        ),
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("After entering your phone number, click on verify to authenticate yourself! Then wait up to 20 seconds to get th OTP and procede", textAlign: TextAlign.center, style: TextStyle(color: grey),),
        ),
        SizedBox(height: 10),
        CustomButton(msg: "Verify", onTap: (){
          auth.verifyPhone(context);
        })
      ]),
    );
  }
}
