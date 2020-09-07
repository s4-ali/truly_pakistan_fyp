import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/ui/widgets/community_post_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class QuestionSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid=FirebaseAuth.instance.currentUser.uid;
    var snap=FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .collection("QueryResults")
        .doc("Question")
        .snapshots();
    return StreamBuilder(
      stream: snap,
      builder: (_,result){
        List<CommunityPostModel> questions;
        if(result.connectionState==ConnectionState.active) {
          var doc = result.data as DocumentSnapshot;
          questions=extractQuestions(doc.data());
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (_,index){
              return CommunityPostWidget(questions[index]);
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<CommunityPostModel> extractQuestions(Map<String, dynamic> data) {
    List<CommunityPostModel> questions=List();
    if(data["hits"]!=null) {
      for(var s in data["hits"] as List<dynamic>){
        questions.add(CommunityPostModel().fromMap(s));
      }
    }
    return questions;
  }
}
