import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const NUMBER = "name";
  static const ID = "id";
  static const CLOSE_CONTACTS = "closeContacts";

  String _name;
  String _id;
  List<String> _closeContacts;

//  getters
  String get name => _name;
  String get id => _id;
  List<String> get closeContacts => _closeContacts;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data[NUMBER];
    _closeContacts = snapshot.data[CLOSE_CONTACTS];
    _id = snapshot.data[ID];
  }
}
