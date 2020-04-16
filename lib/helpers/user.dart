import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/models/user.dart';

class UserServices{

  String collection = "users";
  Firestore _firestore = Firestore.instance;

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    _firestore.collection(collection).document(id).setData(values);
  }

  void updateUserData(Map<String, dynamic> values){
    _firestore.collection(collection).document(values['id']).updateData(values);
  }

  Future<UserModel> getUserById(String id) => _firestore.collection(collection).document(id).get().then((doc){
    if(doc.data == null){
      return null;
    }
    return UserModel.fromSnapshot(doc);
  });
}