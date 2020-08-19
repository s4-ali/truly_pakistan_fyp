import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';

class CommunityRepository{
  Future<List<DocumentSnapshot>> getCommunityPosts() async{
    return Firestore.instance
        .collection("Community")
        .getDocuments()
        .then(
            (value) => value!=null? value.documents: null
    );
  }
  
  Future<String> addCommunityPost(Map<String,dynamic> data)async{
    try {
      Firestore.instance.collection("Community").document().setData(data);
      return null;
    }on PlatformException catch(ex){
      return ex.message;
    }
  } 


}