import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';

class MarketPlaceItemModel{
  List<String> activities;
  String date;
  List<String> day;
  String description;
  int duration;
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

  MarketPlaceItemModel fromMap(Map<String,dynamic> map){
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
    duration=map["duration"];
    from=map["from"];
    if(map["images"]!=null) {
      images=List();
      for(var s in map["images"] as List<dynamic>){
        images.add(s.toString());
      }
    }
    postedAt=(map["postedAt"] as Timestamp).toDate();
    price=map["price"];
    if(map["servicesAvailable"]!=null) {
      servicesAvailable=List();
      for(var s in map["servicesAvailable"] as List<dynamic>){
        servicesAvailable.add(s.toString());
      }
    }
    status=map["status"];
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
}