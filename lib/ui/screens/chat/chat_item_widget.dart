
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_msg_model.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_room_model.dart';

class ChatMessageListItem extends StatelessWidget {
  final ChatMsgModel chat;
  final Animation animation;
  final ChatRoomModel chatRoom;
  ChatMessageListItem(this.chat, this.chatRoom, {this.animation});

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
      sizeFactor:
      new CurvedAnimation(parent: animation, curve: Curves.decelerate),
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: new Row(
          children: chatRoom.currentUser.uid == chat.postedBy
              ? getSentMessageLayout()
              : getReceivedMessageLayout(),
        ),
      ),
    );
  }

  List<Widget> getSentMessageLayout() {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(chatRoom.currentUser.name??"userName",
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:Text(chat.msg),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> getReceivedMessageLayout() {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(chatRoom.otherUser.name,
                style: new TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child:Text(chat.msg),
            ),
          ],
        ),
      ),
    ];
  }
}
