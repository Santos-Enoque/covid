import 'package:covid/providers/auth.dart';
import 'package:covid/providers/bluetooth.dart';
import 'package:covid/screens/enter_blue_address.dart';
import 'package:covid/screens/home.dart';
import 'package:covid/screens/login.dart';
import 'package:covid/screens/on_boarding.dart';
import 'package:covid/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
  ChangeNotifierProvider.value(value: AuthProvider.initialize()),
    ChangeNotifierProvider.value(value: BlueToothProvider.initialize()),

  ],
child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona Out',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreensController()
    );
  }
}


class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    if(auth.status == Status.Uninitialized){
      return Splash();
    }else{
      if(auth.logedIn){
//        the returned widget will depend on wheather the user is bluetooth address or not
      print("The value is: ${auth.bluetoothSet}");
      print("The value is: ${auth.bluetoothSet}");
      print("The value is: ${auth.bluetoothSet}");

      return whichWidgetToReturn(auth.bluetoothSet);
      }else{
        if(auth.firstOpen){
          return OnBoarding();
        }else{
          return Login();
        }
      }
    }
  }

  Widget whichWidgetToReturn(bool setBluetoothAddress){
    if(setBluetoothAddress){
      return Home();
    }else{
      return BluetoothAddress();
    }
  }
}

