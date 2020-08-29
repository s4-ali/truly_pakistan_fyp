import 'dart:collection';
import 'package:truly_pakistan_fyp/static_data.dart' as data;

class UserModel{
  String uid;
  String bio;
  String city;
  String country;
  DateTime dateOfBirth;
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

  bool isCurrentUser;


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
    map["imageUrl"]=imageUrl;
    map["imageUrlCover"]=imageUrlCover;
    map["name"]=name;
    map["state"]=state;
    map["status"]=status;
    map["totalFollowers"]=totalFollowers;
    map["totalFollowing"]=totalFollowers;
    map["twitterURL"]=twitterURL;
    return map;
  }

  UserModel fromMap(Map<String,dynamic> map) {
    bio=map["bio"];
    city=map["city"];
    country=map["country"];
    dateOfBirth=map["dateOfBirth"];
    email=map["email"];
    facebookURL=map["facebookURL"];
    gender=map["gender"];
    phoneNumber=map["phoneNumber"];
    imageUrl=map["imageUrl"];
    imageUrlCover=map["imageUrlCover"];
    name=map["name"];
    state=map["state"];
    status=map["status"];
    totalFollowers=map["totalFollowers"];
    totalFollowers=map["totalFollowers"];
    twitterURL=map["twitterURL"];
    return this;
  }
}