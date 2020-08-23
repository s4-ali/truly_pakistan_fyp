import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/providers/community/community_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/community/add_community_post_screen.dart';
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
            pushNewScreen(context, screen: AddCommunityPostScreen());
          },icon: Icon(Icons.add,color: Theme.of(context).primaryColor,),),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Center(
        child: Consumer<CommunityProvider>(
          builder: (_,communityProvider,__){
            return ListView.builder(
              itemBuilder: (_,index){
                return CommunityPostWidget(communityProvider.getCommunityPosts()[index]);
              },
              itemCount: communityProvider.getCommunityPosts().length,
            );
          },
        ),
      ),
    );
  }
}
