import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_comment_model.dart';

import '../user_model.dart';

class TraveloguePostModel{
  String description;
  int reacts;
  int totalComments;
  DateTime postedAt;
  UserModel user;
  List<String> tags;
  List<String> locations;
  List<String> images;
  List<TravelogueCommentModel> comments;
  String timeElapsed="1 minute ago";
  String id;
  bool isReacted=false;

  TraveloguePostModel fromMap(Map<String, dynamic> map) {
    if(map["description"]!=null && map["description"] is String)
      description=map["description"];
    if(map["postedAt"]!=null && map["postedAt"] is Timestamp)
      timeElapsed=(map["postedAt"] as Timestamp).toDate().toString();
    if(map["reacts"]!=null && map["reacts"] is int)
      reacts=map["reacts"];
    if(map["totalComments"]!=null && map["totalComments"] is int)
      totalComments=map["totalComments"];
    if(map["postedAt"]!=null && map["postedAt"] is DateTime)
      postedAt=map["postedAt"];
    if(map["user"]!=null && map["user"] is Map<dynamic,dynamic>)
      user=UserModel().fromMap(map["user"]);
    if(map["tags"]!=null) {
      tags=List();
      for(var s in map["tags"] as List<dynamic>){
        tags.add(s.toString());
      }
    }
    if(map["locations"]!=null) {
      locations=List();
      for(var s in map["locations"] as List<dynamic>){
        locations.add(s.toString());
      }
    }
    if(map["images"]!=null) {
      images=List();
      for(var s in map["images"] as List<dynamic>){
        images.add(s.toString());
      }
    }
    return this;
  }

  HashMap<String, dynamic> toMap() {
    HashMap<String, dynamic> map=HashMap();
    map["description"]=description;
    map["reacts"]=reacts;
    map["totalComments"]=totalComments;
    map["postedAt"]=postedAt;
    map["user"]=user.toMapBasic();
    map["tags"]=tags;
    map["locations"]=locations;
    map["images"]=images;
    return map;
  }
}