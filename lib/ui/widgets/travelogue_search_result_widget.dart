import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class TravelogueSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid=FirebaseAuth.instance.currentUser.uid;
    var snap=FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .collection("QueryResults")
        .doc("Travelogue")
        .snapshots();
    return StreamBuilder(
      stream: snap,
      builder: (_,result){
        List<TraveloguePostModel> travelogues;
        if(result.connectionState==ConnectionState.active) {
          var doc = result.data as DocumentSnapshot;
          travelogues=extractTravelogues(doc.data());
          return travelogues.length>0?ListView.builder(
            itemCount: travelogues.length,
            itemBuilder: (_,index){
              return TraveloguePostWidget(travelogues[index]);
            },
          ):Center(child: Text("No travelogues found"),);
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<TraveloguePostModel> extractTravelogues(Map<String, dynamic> data) {
    List<TraveloguePostModel> travelogues=List();
    if(data["hits"]!=null) {
      for(var s in data["hits"] as List<dynamic>){
        travelogues.add(TraveloguePostModel().fromMap(s));
      }
    }
    return travelogues;
  }

}
