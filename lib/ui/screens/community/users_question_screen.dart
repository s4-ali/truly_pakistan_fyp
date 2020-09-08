import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/community/community_provider.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/add_travelogue_screen.dart';
import 'package:truly_pakistan_fyp/ui/widgets/community_post_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class UsersQuestionScreen extends StatefulWidget {
  final UserModel user;

  const UsersQuestionScreen({Key key, this.user}) : super(key: key);
  @override
  _UsersQuestionScreenState createState() => _UsersQuestionScreenState();
}

class _UsersQuestionScreenState extends State<UsersQuestionScreen> {

  List<CommunityPostModel> _questions;

  @override
  void initState() {
    super.initState();
    loadTravelogues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.name}'s Travelogues",style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
      ),
      body: _questions==null?Center(child: CircularProgressIndicator(),)
          :_questions.length>0?ListView.builder(
        itemBuilder: (_,index){
          return CommunityPostWidget(
            _questions[index],
          );
        },
        itemCount: _questions.length,
      ):Center(child: Text("${widget.user.name} does not have any questions"),),
    );
  }

  void loadTravelogues() async{
    _questions = await Provider.of<CommunityProvider>(context,listen: false).getCommunityPostsByUser(widget.user);
    setState(() {

    });
  }
}
