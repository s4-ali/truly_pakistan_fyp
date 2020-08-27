import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class CommunityRepository {

  Future<List<DocumentSnapshot>> getCommunityPosts() async {
    return FirebaseFirestore.instance
        .collection("Community")
        .orderBy("postedAt")
        .get()
        .then(
            (value) => value != null ? value.docs : null
    );
  }

  Future<String> addCommunityPost(Map<String, dynamic> data) async {
    try {
      await FirebaseFirestore.instance
          .collection("Community")
          .doc()
          .set(data);
      return null;
    } on PlatformException catch (ex) {
      return ex.message;
    }
  }

  Future<String> addAnswerTo(String postId,Map<String,dynamic> data)async{
    try {
      await FirebaseFirestore.instance
          .collection("Community")
          .doc(postId)
          .collection("Answers").doc().set(data);
      return null;
    } on PlatformException catch (ex) {
      return ex.message;
    }
  }

  Future voteOnPost(String postId,String uid,Map<String,dynamic> data)async{
    await FirebaseFirestore.instance
        .collection("Community")
        .doc(postId)
        .collection("Votes")
        .doc(uid)
        .set(data);
  }

  Future<List<DocumentSnapshot>>
    getCommunityAnswersFor(String postId)
    async{
      return FirebaseFirestore.instance
          .collection("Community")
          .doc(postId)
          .collection("Answers").get().then(
              (value) => value != null ? value.docs : null
      );
  }
}