import 'dart:collection';

import 'package:truly_pakistan_fyp/models/UserModel.dart';
import 'package:truly_pakistan_fyp/models/community/community_answer_model.dart';

class CommunityPostModel{
  String title;
  String description;
  String upVotes;
  String downVotes;
  String totalVotes;
  String totalAnswers;
  DateTime postedAt;
  UserModel user;
  List<String> tags;
  List<String> images;
  List<CommunityAnswerModel> answers;

  CommunityPostModel fromMap(Map<String, dynamic> data) {
    return this;
  }

  HashMap<String, double> toMap() {
    HashMap map=HashMap();
    return map;
  }
}