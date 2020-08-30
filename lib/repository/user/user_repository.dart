import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class UserRepository{
  Future<String> updateUserInfo(Map<String,dynamic> info,String uid)async{
    try{
      FirebaseFirestore.instance.collection("users").doc(uid).set(info,SetOptions(merge: true));
      return null;
    }on PlatformException catch(ex){
      return ex.message;
    }
  }

  Future<Map<String,dynamic>> getUserInfo(String uid)async{
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then(
            (value) => value != null ? value.data() : null
    );
  }
}