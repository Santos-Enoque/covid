import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BlueToothProvider with ChangeNotifier{
  FlutterBlue flutterBlue = FlutterBlue.instance;

  BlueToothProvider.initialize(){
    searchForDevices();
  }

  Future<void> searchForDevices()async{
    print("started the search");
    String id = await _getId();

    print("THE CURRENT DEVICE ID ID: $id");

    bool on = await flutterBlue.isOn;
    if(!on){
      print("==== TURN ON YOUR BLUETHOOTH PLEASE ====");
      return;
    }

    print("scaning");
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 40));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.id} found! rssi: ${r.rssi}');
      }
    });

    // Stop scanning
    flutterBlue.stopScan();


  }

  Future<String> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//      if (Theme.of(context).platform == TargetPlatform.iOS) {
//        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
//        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//      } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
//      }
  }
}