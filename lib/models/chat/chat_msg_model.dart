import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMsgModel{
  String msg;
  String postedBy;
  Timestamp postedAt;

  ChatMsgModel fromMap(Map<String,dynamic> map){
    this.msg=map["text"];
    this.postedBy=map["postedBy"];
    this.postedAt=map["postedAt"];
    return this;
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    map["text"]=this.msg;
    map["postedBy"]=this.postedBy;
    map["postedAt"]=this.postedAt;
    return map;
  }

}