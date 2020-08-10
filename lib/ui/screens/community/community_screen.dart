import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/ui/widgets/community_post_widget.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Community",style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(onPressed: (){

          },icon: Icon(Icons.add,color: Theme.of(context).primaryColor,),),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: ListView(
          children: <Widget>[
            CommunityPostWidget(),
            CommunityPostWidget(),
          ],
        ),
      ),
    );
  }
}
