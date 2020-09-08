import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../user_model.dart';

class CommunityAnswerModel{

  String id;
  String text;
  String votes;
  int upVotes;
  int downVotes;
  UserModel user;
  DateTime postedAt;

  int currentVote=0;

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
    map["user"]=user.toMapBasic();
    return map;
  }

}