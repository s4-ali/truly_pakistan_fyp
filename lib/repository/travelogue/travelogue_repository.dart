import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class TravelogueRepository {

  Future<List<DocumentSnapshot>> getTraveloguePosts() async {
    return FirebaseFirestore.instance
        .collection("Travelogue")
        .orderBy("postedAt",descending: true)
        .get()
        .then(
            (value) => value != null ? value.docs : null
    );
  }

  Future<String> addTraveloguePost(Map<String, dynamic> data) async {
    try {
      data["postedAt"]=FieldValue.serverTimestamp();

      await FirebaseFirestore.instance
          .collection("Travelogue")
          .doc()
          .set(data);
      return null;
    } on PlatformException catch (ex) {
      return ex.message;
    }
  }

  Future<String> addAnswerTo(String postId,Map<String,dynamic> data)async{
    try {
      data["postedAt"]=FieldValue.serverTimestamp();

      await FirebaseFirestore.instance
          .collection("Travelogue")
          .doc(postId)
          .collection("Comments").doc().set(data);
      return null;
    } on PlatformException catch (ex) {
      return ex.message;
    }
  }

  Future reactOnPost(String postId,String uid,Map<String,dynamic> data)async{
    await FirebaseFirestore.instance
        .collection("Travelogue")
        .doc(postId)
        .collection("Reacts")
        .doc(uid)
        .set(data);
  }

  Future<List<DocumentSnapshot>>
  getTravelogueCommentsFor(String postId)
  async{
    return FirebaseFirestore.instance
        .collection("Travelogue")
        .doc(postId)
        .collection("Comments").get().then(
            (value) => value != null ? value.docs : null
    );
  }

  Future<List<DocumentSnapshot>> getTraveloguePostsBy(String uid) async{
    return await FirebaseFirestore.instance
        .collection("Travelogue")
        .where("user.uid",isEqualTo: uid)
        .orderBy("postedAt",descending: true)
        .get()
        .then(
            (value) => value != null ? value.docs : null
    );
  }

}