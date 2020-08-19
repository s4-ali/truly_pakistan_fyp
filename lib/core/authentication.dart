import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailAndPassword(String email, String password,String name);
  Future<FirebaseUser> currentUser();
  Future<void> signOut();
}

class Authentication implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> signInWithEmailAndPassword(String email, String password) async {
    print("signInWithEmailAndPassword");
    final FirebaseUser user = (await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user?.uid;
  }

  @override
  Future<String> createUserWithEmailAndPassword(String email, String password,String name) async {
    final FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user;
    UserUpdateInfo userInfo=UserUpdateInfo();
    userInfo.displayName=name;
    await user.updateProfile(userInfo);
    await user.sendEmailVerification();
    await Firestore.instance.collection("users").document(user.uid).setData({
      "status":1,
      "displayName":name,
      "email":email,
    },merge: true);
    await Firestore.instance.collection("users").document(user.uid).setData({},merge: true);
    return user?.uid;
  }

  @override
  Future<FirebaseUser> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<bool> isEmailVerified(){
    return _firebaseAuth.currentUser().then((user){
      return user.isEmailVerified;
    });
  }

  @override
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<bool> isPhoneNumberAdded() {
    return _firebaseAuth.currentUser().then((user){
      print(user.phoneNumber);
      return user.phoneNumber!=null;
    });
  }


  Future<bool> signInWithCode(String code){
    AuthCredential authCredential=PhoneAuthProvider.getCredential(verificationId: _smsVerificationCode, smsCode: code);
    return _firebaseAuth.currentUser().then((user) {
      return user.linkWithCredential(authCredential).then((user) {
        return true;
      }).catchError((e) {
        return false;
      });
    });
  }

  _addPhoneNumber(BuildContext context,String phoneNumber,Function verificationComplete,Function verificationFailed) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (authCredential) => verificationComplete(authCredential, context),
        verificationFailed: (authException) => verificationFailed(authException, context),
        codeAutoRetrievalTimeout: (verificationId) => _codeAutoRetrievalTimeout(verificationId),
        // called when the SMS code is sent
        codeSent: (verificationId, [code]) => _smsCodeSent(verificationId, [code]));
  }

  /// will get an AuthCredential object that will help with logging into Firebase.
  _verificationComplete(AuthCredential authCredential, BuildContext context) {
    FirebaseAuth.instance.signInWithCredential(authCredential).then((authResult) {
      final snackBar = SnackBar(content: Text("Success!!! UUID is: " + authResult.user.uid));
      Scaffold.of(context).showSnackBar(snackBar);
    });
  }
  String _smsVerificationCode;
  String _smsVerificationId;
  _smsCodeSent(String verificationId, List<int> code) {
    print("_smsCodeSent$verificationId");
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  _verificationFailed(AuthException authException, BuildContext context) {
    final snackBar = SnackBar(content: Text("Exception!! message:" + authException.message.toString()));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    print("_codeAutoRetrievalTimeout");
    // set the verification code so that we can use it to log the user in
    _smsVerificationCode = verificationId;
  }

  Future resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

}
