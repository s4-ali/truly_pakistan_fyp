import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';

class MarketPlaceItemModel{
  List<String> activities;
  String date;
  List<String> day;
  String description;
  String duration;
  String from;
  List<String> images;
  DateTime postedAt;
  int price;
  List<String> servicesAvailable;
  int status;
  List<String> tags;
  String title;
  String to;
  UserModel user;
  String id;

  MarketPlaceItemModel fromMap(Map<String,dynamic> map){
    if(map["objectID"]!=null&&map["objectID"] is String)
      id=map["objectID"];
    if(map["activities"]!=null) {
      activities=List();
      for(var s in map["activities"] as List<dynamic>){
        activities.add(s.toString());
      }
    }
    date=map["date"];
    if(map["day"]!=null) {
      day=List();
      for(var s in map["day"] as List<dynamic>){
        day.add(s.toString());
      }
    }
    description=map["description"];
    if(map["duration"] is String)
      duration=map["duration"];
    else if(map["duration"] is int)
      duration=map["duration"].toString();
    from=map["from"];
    if(map["images"]!=null) {
      images=List();
      for(var s in map["images"] as List<dynamic>){
        images.add(s.toString());
      }
    }
    if(map["postedAt"] is Timestamp)
      postedAt=(map["postedAt"] as Timestamp).toDate();
    if(map["price"] is int)
      price=map["price"];
    else if(map["price"] is String){
      price=int.parse(map["price"]);
    }
    if(map["servicesAvailable"]!=null) {
      servicesAvailable=List();
      for(var s in map["servicesAvailable"] as List<dynamic>){
        servicesAvailable.add(s.toString());
      }
    }
    if(map["status"] is int)
      status=map["status"];
    else if(map["status"] is String)
      status=int.parse(map["status"]);
    if(map["tags"]!=null) {
      tags=List();
      for(var s in map["tags"] as List<dynamic>){
        tags.add(s.toString());
      }
    }

    title=map["title"];
    to=map["to"];
    user=UserModel().fromMap(map["user"]);
    return this;
  }

  Map<String,dynamic> toMap() {
    Map<String,dynamic> map=Map();
    map["activities"]=activities;
    map["date"]=date;
    map["day"]=day;
    map["description"]=description;
    map["duration"]=duration;
    map["from"]=from;
    map["images"]=images;
    map["postedAt"]=postedAt;
    map["price"]=price;
    map["servicesAvailable"]=servicesAvailable;
    map["status"]=status;
    map["tags"]=tags;
    map["title"]=title;
    map["to"]=to;
    map["user"]=user.toMapBasic();
    return map;
  }
}