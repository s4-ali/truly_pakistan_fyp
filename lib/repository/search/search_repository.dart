import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SearchRepository{
  Future<String> performSearch(Map<String,dynamic> query,String uid)async{
    try {
      print("SearchRepository:$query");
      print("SearchRepository:$uid");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("Query")
          .doc()
          .set(query);
      return null;
    }on PlatformException catch(ex){
      return ex.message;
    }
  }
}