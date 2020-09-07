import 'dart:collection';

import 'package:truly_pakistan_fyp/models/community/community_answer_model.dart';

import '../user_model.dart';

class CommunityPostModel{
  String title;
  String description;
  int upVotes;
  int downVotes;
  int totalVotes;
  int totalAnswers;
  DateTime postedAt;
  UserModel user;
  List<String> tags;
  List<String> locations;
  List<String> images;
  List<CommunityAnswerModel> answers;
  String timeElapsed="1 minute ago";
  String id;
  int currentVote=0;

  CommunityPostModel fromMap(Map<String, dynamic> map) {
    if(map["objectID"]!=null&&map["objectID"] is String)
      id=map["objectID"];
    if(map["title"]!=null && map["title"] is String)
      title=map["title"];
    if(map["description"]!=null && map["description"] is String)
      description=map["description"];
    if(map["upVotes"]!=null && map["upVotes"] is int)
      upVotes=map["upVotes"];
    if(map["downVotes"]!=null && map["downVotes"] is int)
      downVotes=map["downVotes"];
    if(map["totalVotes"]!=null && map["totalVotes"] is int)
      totalVotes=map["totalVotes"];
    if(map["totalAnswers"]!=null && map["totalAnswers"] is int)
      totalAnswers=map["totalAnswers"];
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
    map["title"]=title;
    map["description"]=description;
    map["upVotes"]=upVotes;
    map["downVotes"]=downVotes;
    map["totalVotes"]=totalVotes;
    map["totalAnswers"]=totalAnswers;
    map["postedAt"]=postedAt;
    map["user"]=user.toMapBasic();
    map["tags"]=tags;
    map["locations"]=locations;
    map["images"]=images;
    return map;
  }
}