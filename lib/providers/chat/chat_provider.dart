import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_room_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/repository/chat/chat_repository.dart';

class ChatProvider extends ChangeNotifier{
  List<ChatRoomModel> chatRooms;
  ChatRepository _chatRepository;
  UserModel currentUser;

  ChatProvider(){
    _chatRepository=ChatRepository();
    chatRooms=List();
  }

  getChatRoomQuery(){
    return _chatRepository.chatRoomsQuery(currentUser.uid);
  }

  Future<List<ChatRoomModel>>loadChatsList()async{
    if(chatRooms!=null)return chatRooms;
    if(currentUser!=null) {
      var docs = await _chatRepository.loadChatsList(currentUser.uid);
      for(DocumentSnapshot doc in docs){
        chatRooms.add(ChatRoomModel().fromMap(doc.data(), currentUser.uid)..roomId=doc.id);
      }
    }
    return chatRooms;
  }

  Future<dynamic> getChatWith(UserModel userModel)async{
    var rooms=await loadChatsList();
    for(var room in rooms){
      if(room.otherUser.uid==userModel.uid)
        return room;
    }
    var uid1=currentUser.uid;
    var uid2=userModel.uid;
    var room=ChatRoomModel();
    room.users.add(currentUser.uid);
    room.users.add(userModel.uid);
    room.roomId=uid1.compareTo(uid2)<0?uid1+uid2:uid2+uid1;
    room.currentUser=currentUser;
    room.otherUser=userModel;
    var res=await _chatRepository.createRoom(room.toMap(),room.roomId);
    if(res!=null)return res;
    chatRooms.add(room);
    return room;
  }

  void init(UserModel currentUser) {
    this.currentUser=currentUser;
    loadChatsList();
  }
}