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

  Future<DocumentSnapshot> getFollowingDocument(String uid, String otherUid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Following")
        .doc(otherUid).get();
  }

  Future<String> removeFromFollowing(String uid, String otherUid) async{
    try {
      await FirebaseFirestore.instance.collection("users")
          .doc(uid)
          .collection("Following")
          .doc(otherUid).delete();
      return null;
    }on PlatformException catch(ex){
      return ex.message;
    }
  }

  Future<String> addFollowing(String uid, String otherUid, Map<String, String> data) async{
    try{
      await FirebaseFirestore.instance.collection("users")
          .doc(uid)
          .collection("Following")
          .doc(otherUid)
          .set(data);
      return null;
    }on PlatformException catch(ex){
      return ex.message;
    }

  }

  Future<List<DocumentSnapshot>> getFollowerOf(String uid) async {
    return (await FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .collection("Followers")
        .get()).docs;
  }
  Future<List<DocumentSnapshot>> getFollowingOf(String uid) async {
    return (await FirebaseFirestore.instance.collection("users")
        .doc(uid)
        .collection("Following")
        .get()).docs;
  }

}