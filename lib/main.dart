import 'package:covid/providers/auth.dart';
import 'package:covid/screens/login.dart';
import 'package:covid/screens/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
  ChangeNotifierProvider.value(value: AuthProvider.initialize())
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
      home: OnBoarding()
    );
  }
}
