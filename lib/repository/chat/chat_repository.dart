import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class ChatRepository{
  Future<List<DocumentSnapshot>> loadChatsList(String uid) async{
    return (await FirebaseFirestore.instance
        .collection("Chats")
        .where("users",arrayContains: uid)
        .orderBy("lastModified")
        .get()).docs;
  }

  Future<String> createRoom(Map<String, dynamic> map, String roomId) async{
    try{
      await FirebaseFirestore.instance
        .collection("Chats")
        .doc(roomId)
        .set(map);
      return null;
    }on PlatformException catch(ex){
      return ex.message;
    }
  }

  Future<QuerySnapshot> chatRoomsQuery(String uid) {
    return FirebaseFirestore.instance
        .collection("Chats")
        .where("users",arrayContains: uid)
        .orderBy("lastModified")
        .get();
  }


}