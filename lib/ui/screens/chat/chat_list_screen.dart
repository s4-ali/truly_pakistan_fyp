import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_room_model.dart';
import 'package:truly_pakistan_fyp/providers/chat/chat_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/chat/chat_screen.dart';

class ChatsListScreen extends StatefulWidget {
  @override
  _ChatsListScreenState createState() => _ChatsListScreenState();
}

class _ChatsListScreenState extends State<ChatsListScreen> {
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    uid = Provider.of<UserProvider>(context, listen: false).getCurrentUser().uid;
    print("uid:$uid");
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Color(0xff00ABA9),
          title: Center(child: Text('Chats')),
        ),
        body: FutureBuilder(
          future: Provider.of<ChatProvider>(context).loadChatsList(),
          builder: (_,snap){
            var chatRooms=snap.data as List<ChatRoomModel>;
            if(chatRooms.isEmpty){
              return Center(
                child: Text("You don't have any chats"),
              );
            }
            return ListView.builder(
              itemBuilder: (_,index){
                return InkWell(
                  onTap: (){
                    pushNewScreen(context, screen: ChatScreen(chatRooms[index]));
                  },
                  child: Container(
                    child: Text(chatRooms[index].otherUser.name),
                  ),
                );
              },
              itemCount: chatRooms.length,
            );
          },
        ),
    );
  }
}
