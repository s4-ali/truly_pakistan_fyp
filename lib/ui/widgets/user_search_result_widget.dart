import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/ui/widgets/community_post_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/follow_tile_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class UserSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid=FirebaseAuth.instance.currentUser.uid;
    var snap=FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .collection("QueryResults")
        .doc("User")
        .snapshots();
    return StreamBuilder(
      stream: snap,
      builder: (_,result){
        List<UserModel> users;
        if(result.connectionState==ConnectionState.active) {
          var doc = result.data as DocumentSnapshot;
          users=extractUsers(doc.data());
          return users.length>0?ListView.builder(
            itemCount: users.length,
            itemBuilder: (_,index){
              return FollowTileWidget(user:users[index]);
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

  List<UserModel> extractUsers(Map<String, dynamic> data) {
    List<UserModel> users=List();
    if(data["hits"]!=null) {
      for(var s in data["hits"] as List<dynamic>){
        users.add(UserModel().fromMap(s));
      }
    }
    return users;
  }
}
