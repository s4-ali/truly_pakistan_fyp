import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truly_pakistan_fyp/models/UserModel.dart';

class CommunityAnswerModel{
  String id;
  String text;
  String votes;
  int upVotes;
  int downVotes;
  UserModel user;
  DateTime postedAt;

  CommunityAnswerModel fromMap(Map<String,dynamic> map) {
    this.text=map["text"];
    this.upVotes=map["upVotes"];
    this.downVotes=map["downVotes"];
    this.postedAt=(map["postedAt"] as Timestamp)?.toDate();
    this.user=UserModel().fromMap(map["user"]);
    votes="${upVotes-downVotes}";
    return this;
  }

  Map<String, dynamic> toMap() {
    var map=HashMap<String,dynamic>();
    map["text"]=this.text;
    map["upVotes"]=this.upVotes;
    map["downVotes"]=this.downVotes;
    map["postedAt"]=this.postedAt;
    map["user"]=user.toMap();
    return map;
  }
}