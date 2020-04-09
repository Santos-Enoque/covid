import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = "number";
  static const ID = "id";
  static const DEVICE_ID = "deviceId";
  static const CLOSE_CONTACTS = "closeContacts";

  String _number;
  String _id;
  String _deviceId;
  List<String> _closeContacts;

//  getters
  String get number => _number;
  String get id => _id;
  String get deviceId => _deviceId;
  List<String> get closeContacts => _closeContacts;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _number = snapshot.data[NUMBER];
    _closeContacts = snapshot.data[CLOSE_CONTACTS];
    _id = snapshot.data[ID];
    _deviceId = snapshot.data[DEVICE_ID];

  }
}
