import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../user_model.dart';

class TravelogueCommentModel{
  String id;
  String text;
  String reacts;
  UserModel user;
  DateTime postedAt;

  TravelogueCommentModel fromMap(Map<String,dynamic> map) {
    this.text=map["text"];
    this.reacts=map["reacts"];
    this.postedAt=(map["postedAt"] as Timestamp)?.toDate();
    this.user=UserModel().fromMap(map["user"]);
    return this;
  }

  Map<String, dynamic> toMap() {
    var map=HashMap<String,dynamic>();
    map["text"]=this.text;
    map["postedAt"]=this.postedAt;
    map["user"]=user.toMapBasic();
    return map;
  }
}