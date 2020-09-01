import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_msg_model.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_room_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/chat/chat_item_widget.dart';

class ChatScreen extends StatefulWidget {

  final ChatRoomModel chatRoom;

  const ChatScreen(this.chatRoom, {Key key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textEditingController =
  new TextEditingController();
  bool _isComposingMessage=false;
  CollectionReference messagesReference;

  @override
  Widget build(BuildContext context) {
    messagesReference=FirebaseFirestore.instance.collection('Chats').doc(widget.chatRoom.roomId).collection('Messages');

    return new Scaffold(

        appBar: new AppBar(
          title: new Text(widget.chatRoom.otherUser.name,style: TextStyle(color: Theme.of(context).primaryColor),),
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          brightness: Brightness.light,
          centerTitle: true,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        ),
        body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                child: new FirestoreAnimatedList(
                  query: messagesReference.orderBy('postedAt',descending: true),
                  padding: const EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_,messageSnapshot,animation,index) {
                    return new ChatMessageListItem(
                      ChatMsgModel().fromMap(messageSnapshot.data()),
                      widget.chatRoom,
                      animation: animation,
                    );
                  },
                ),
              ),
              new Divider(height: 1.0),
              new Container(
                decoration:
                new BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
              new Builder(builder: (BuildContext context) {
                return new Container(width: 0.0, height: 0.0);
              })
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
              border: new Border(
                  top: new BorderSide(
                    color: Colors.grey[200],
                  )))
              : null,
        ));
  }

  CupertinoButton getIOSSendButton() {
    return new CupertinoButton(
      child: new Text("Send"),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  IconButton getDefaultSendButton() {
    return new IconButton(
      icon: new Icon(Icons.send),
      onPressed: _isComposingMessage
          ? () => _textMessageSubmitted(_textEditingController.text)
          : null,
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(
          color: _isComposingMessage
              ? Theme.of(context).primaryColor
              : Theme.of(context).primaryColor.withAlpha(150),
        ),
        child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textEditingController,
                  onChanged: (String messageText) {
                    setState(() {
                      _isComposingMessage = messageText.length > 0;
                    });
                  },
                  onSubmitted: _textMessageSubmitted,
                  decoration:
                  new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              new Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Theme.of(context).platform == TargetPlatform.iOS
                    ? getIOSSendButton()
                    : getDefaultSendButton(),
              ),
            ],
          ),
        ));
  }


  Future<Null> _textMessageSubmitted(String text) async {
    _textEditingController.clear();

    setState(() {
      _isComposingMessage = false;
    });
    _sendMessage(text);
  }

  void _sendMessage(String messageText) {
    messagesReference.document().setData({
      'text':messageText,
      'postedBy':widget.chatRoom.currentUser.uid,
      'postedAt':FieldValue.serverTimestamp(),
    });
  }
}

