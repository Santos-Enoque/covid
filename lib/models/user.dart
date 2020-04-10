import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = "number";
  static const ID = "id";
  static const BLUETOOTH_ADDRESS = "bluetoothAddress";
  static const CLOSE_CONTACTS = "closeContacts";

  String _number;
  String _id;
  String _bluetoothAddress;
  List _closeContacts;

//  getters
  String get number => _number;
  String get id => _id;
  String get bluetoothAddress => _bluetoothAddress;
  List<String> get closeContacts => _closeContacts;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _number = snapshot.data[NUMBER];
    _closeContacts = snapshot.data[CLOSE_CONTACTS];
    _id = snapshot.data[ID];
    _bluetoothAddress = snapshot.data[BLUETOOTH_ADDRESS];

  }
}
