import 'dart:collection';
import 'package:truly_pakistan_fyp/static_data.dart' as data;

class UserModel{
  String uid;
  String bio;
  String city;
  String country;
  String dateOfBirth;
  String email;
  String facebookURL;
  String gender;
  String phoneNumber;
  String imageUrl=data.imageUrl;
  String imageUrlCover=data.imageUrl;
  String name;
  String state;
  int status;
  int totalFollowers;
  int totalFollowing;
  String twitterURL;

  bool isCurrentUser=false;


  HashMap<String,dynamic> toMapBasic() {
    HashMap<String,dynamic> map=HashMap();
    map["uid"]=uid;
    map["imageUrl"]=imageUrl;
    map["name"]=name;
    return map;
  }

  HashMap<String,dynamic> toMap() {
    HashMap<String,dynamic> map=HashMap();
    map["bio"]=bio;
    map["city"]=city;
    map["country"]=country;
    map["dateOfBirth"]=dateOfBirth;
    map["email"]=email;
    map["facebookURL"]=facebookURL;
    map["gender"]=gender;
    map["phoneNumber"]=phoneNumber;
    map["profilePicture"]=imageUrl;
    map["coverPicture"]=imageUrlCover;
    map["name"]=name;
    map["state"]=state;
    map["status"]=status;
    map["totalFollowers"]=totalFollowers;
    map["totalFollowing"]=totalFollowing;
    map["twitterURL"]=twitterURL;
    return map;
  }

  UserModel fromMap(Map<String,dynamic> map) {
    if(map["objectID"]!=null&&map["objectID"] is String)
      uid=map["objectID"];
    if(map["uid"]!=null)
      uid=map["uid"];
    bio=map["bio"];
    city=map["city"];
    country=map["country"];
    dateOfBirth=map["dateOfBirth"];
    email=map["email"];
    facebookURL=map["facebookURL"];
    gender=map["gender"];
    phoneNumber=map["phoneNumber"];
    imageUrl=map["profilePicture"];
    imageUrlCover=map["coverPicture"];
    name=map["name"];
    state=map["state"];
    status=map["status"];
    if(map["totalFollowing"] is int){
      totalFollowing=map["totalFollowing"] as int;
    }else if(map["totalFollowing"] is double){
      totalFollowing=(map["totalFollowing"] as double).toInt();
    }
    if(map["totalFollowers"] is int){
      totalFollowers=map["totalFollowers"] as int;
    }else if(map["totalFollowers"] is double){
      totalFollowers=(map["totalFollowers"] as double).toInt();
    }
    twitterURL=map["twitterURL"];
    return this;
  }

  void clear() {}
}