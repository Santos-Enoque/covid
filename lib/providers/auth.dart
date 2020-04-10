import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid/helpers/screen_navigation.dart';
import 'package:covid/helpers/user.dart';
import 'package:covid/models/user.dart';
import 'package:covid/screens/enter_blue_address.dart';
import 'package:covid/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class AuthProvider with ChangeNotifier{
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  // Firestore _firestore = Firestore.instance;
  UserServices _userServicse = UserServices();
  UserModel _userModel;
  TextEditingController phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  bool firstOpen;
  bool logedIn;
  bool loading = false;
  bool bluetoothSet;




//  getter
  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;


  TextEditingController address = TextEditingController();


  AuthProvider.initialize(){
    readPrefs();
  }

  Future signOut()async{
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> readPrefs()async{
    await Future.delayed(Duration(seconds: 3)).then((v)async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      firstOpen = prefs.getBool('firstOpen') ?? true;
      logedIn = prefs.getBool('logedIn') ?? false;


      if(!logedIn){
        _status = Status.Unauthenticated;
      }else{
        _user = await _auth.currentUser();
        _userModel = await _userServicse.getUserById(_user.uid);
        if(_userModel != null){
          if(_userModel.bluetoothAddress.isNotEmpty){
            await prefs.setBool("bluetoothSet", true);
          }
        }
        _status = Status.Authenticated;
      }

      bluetoothSet = prefs.getBool('bluetoothSet') ?? false;


      if(firstOpen){
        await prefs.setBool("firstOpen", false);
      }
      notifyListeners();
    });
  }

// ! PHONE AUTH
  Future<void> verifyPhone(BuildContext context, String number) async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsOTPDialog(context).then((value) {
        print('sign in');
      });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: number.trim(), // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
          smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential.toString() + "lets make this work");
          },
          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message} + something is wrong');
          });
    } catch (e) {
      handleError(e, context);
      errorMessage = e.toString();
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return  AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: ()async {
                  loading = true;
                  notifyListeners();
                  _auth.currentUser().then((user) async{
                    if (user != null) {
                      _userModel = await _userServicse.getUserById(user.uid);
                      if(_userModel == null){
                        _createUser(id: user.uid, number: user.phoneNumber);
                      }
                      Navigator.of(context).pop();
                      loading = false;
                      notifyListeners();
                      changeScreenReplacement(context, Home());
                    } else {
                      loading = true;
                      notifyListeners();
                      Navigator.of(context).pop();
                      signIn(context);
                    }
                  });
                },
              )
            ],
          );
        });
  }


  signIn(BuildContext context) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final AuthResult user = await _auth.signInWithCredential(credential);
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.user.uid == currentUser.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("logedIn", true);
      logedIn =  true;
      if (user != null) {
        _userModel = await _userServicse.getUserById(user.user.uid);
        if(_userModel == null){
          _createUser(id: user.user.uid, number: user.user.phoneNumber);
        }else{
          if(_userModel.bluetoothAddress != null){
            await prefs.setBool("bluetoothSet", true);
          }
        }

        loading = false;
        Navigator.of(context).pop();
        if(bluetoothSet){
          changeScreenReplacement(context, Home());
        }else{
          changeScreenReplacement(context, BluetoothAddress());
        }
      }
      loading = false;

      Navigator.of(context).pop();
      changeScreenReplacement(context, Home());
      notifyListeners();

    } catch (e) {
      handleError(e, context);
    }

  }

  handleError(error, BuildContext context) {
    print(error);
    errorMessage = error.toString();
    notifyListeners();
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        errorMessage = 'Invalid Code';
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        errorMessage = error.message;
        break;
    }
    notifyListeners();
  }

  void _createUser({String id, String number}){
    _userServicse.createUser({
      "id": id,
      "number": number,
      "closeContacts": [],
      "bluetoothAddress": ""
    });
  }

  Future<void> setBluetoothAddress({String id, String bluetoothAddress})async{
    if(_userModel == null){
      _createUser(id: _user.uid, number: _user.phoneNumber);
    }
    updateUser({"id":id, "bluetoothAddress": bluetoothAddress});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("bluetoothSet", true);
  }

  void updateUser(Map<String, dynamic> values){
    _userServicse.updateUserData(values);
  }
}