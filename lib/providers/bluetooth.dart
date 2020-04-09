import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';

class BlueToothProvider with ChangeNotifier{

  BlueToothProvider.initialize(){
    searchForDevices();
  }

  Future<void> searchForDevices()async{
    print("started the search");
    WifiInfoWrapper wifiObject = await  WifiInfoPlugin.wifiDetails;


    print("THE CURRENT DEVICE ID ID: ${wifiObject.ssid}");

    FlutterBlue flutterBlue = FlutterBlue.instance;





  }

  Future<String> _getId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//      if (Theme.of(context).platform == TargetPlatform.iOS) {
//        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
//        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
//      } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId;// unique ID on Android
//      }
  }
}