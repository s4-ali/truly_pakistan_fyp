import 'dart:collection';

class UserModel{
  String uid;
  String name;
  String profileUrl;

  HashMap<String,dynamic> toMap() {
    HashMap<String,dynamic> map=HashMap();
    map["uid"]=uid;
    map["name"]=name;
    map["profileUrl"]=profileUrl;
    return map;
  }
}