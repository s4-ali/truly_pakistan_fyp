import 'package:truly_pakistan_fyp/models/user_model.dart';

class ChatRoomModel{
  List<String> users=List();
  String roomId;
  UserModel currentUser;
  UserModel otherUser;

  ChatRoomModel fromMap(Map<String,dynamic> map,String userId){
    if(map["users"]!=null) {
      for(var s in map["users"] as List<dynamic>){
        if(s.toString()!=userId) {
          this.otherUser.uid = s.toString();
          break;
        }
      }
    }
    if(map[this.otherUser.uid]!=null&&map[this.otherUser.uid] is Map){
      this.otherUser.name=(map[this.otherUser.uid] as Map)["name"];
      this.otherUser.imageUrl=(map[this.otherUser.uid] as Map)["imageUrl"];
    }
    return this;
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    Map<String,dynamic> otherUserMap=Map();
    otherUserMap["name"]=otherUser.name;
    otherUserMap["imageUrl"]=otherUser.imageUrl;
    map[otherUser.uid]=otherUserMap;
    Map<String,dynamic> currentUserMap=Map();
    currentUserMap["name"]=currentUser.name;
    currentUserMap["imageUrl"]=currentUser.imageUrl;
    map[currentUser.uid]=currentUserMap;
    map["users"]=users;
    return map;
  }
}