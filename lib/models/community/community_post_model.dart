import 'dart:collection';

import 'package:truly_pakistan_fyp/models/UserModel.dart';
import 'package:truly_pakistan_fyp/models/community/community_answer_model.dart';

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

  CommunityPostModel fromMap(Map<String, dynamic> map) {
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
      user=map["user"];
    if(map["tags"]!=null && map["tags"] is List<String>)
      tags=map["tags"];
    if(map["locations"]!=null && map["locations"] is List<String>)
      locations=map["locations"];
    if(map["images"]!=null && map["images"] is List<String>)
      images=map["images"];
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
    map["user"]=user.toMap();
    map["tags"]=tags;
    map["locations"]=locations;
    map["images"]=images;
    return map;
  }
}