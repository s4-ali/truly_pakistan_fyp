import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/UserModel.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_comment_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class CommentsBottomSheet extends StatefulWidget {
  final TraveloguePostModel traveloguePostModel;

  const CommentsBottomSheet(this.traveloguePostModel,{Key key}) : super(key: key);
  @override
  _CommentsBottomSheetState createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {

  TextEditingController _addCommentController;

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: MediaQuery.of(context).size.height*0.75,
      margin: EdgeInsets.only(left: 16,right: 16,bottom: 16+MediaQuery.of(context).viewInsets.bottom,top: 36),
      padding: EdgeInsets.only(bottom: 16,top: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).accentColor,
      ),
      child: ListView.builder(
        itemBuilder: (_,index){
          if(index==0)
            return Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _addCommentController,
                onEditingComplete: ()async{
                  if(_addCommentController.text.isEmpty)return;
                  var fUser=FirebaseAuth.instance.currentUser;
                  UserModel user=UserModel()
                    ..name=fUser.displayName
                    ..uid=fUser.uid
                    ..profileUrl=fUser.photoURL;
                  TravelogueCommentModel comment=TravelogueCommentModel()
                    ..text=_addCommentController.text
                    ..postedAt=DateTime.now()
                    ..user=user;
                  await Provider.of<TravelogueProvider>(context,listen: false)
                      .addNewCommentTo(widget.traveloguePostModel, comment);
                  setState(() {
                    _addCommentController.clear();
                    FocusScope.of(context).unfocus();
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none, hintText: "Got any comments?",
                ),
              ),
            );
          else
            return _commentWidget(widget.traveloguePostModel.comments[index-1]);
        },
        shrinkWrap: true,
        itemCount: widget.traveloguePostModel.comments.length+1,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _addCommentController=TextEditingController();
  }

  Widget _commentWidget(TravelogueCommentModel travelogueCommentModel){
    return Container(
      margin: EdgeInsets.only(top: 16,right: 16,left: 16),
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(0,3),blurRadius: 3)],
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: (travelogueCommentModel.user.profileUrl!=null
                &&travelogueCommentModel.user.profileUrl.isNotEmpty) ?
            CachedNetworkImage(
              imageUrl: travelogueCommentModel.user.profileUrl,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ):Icon(Icons.person,size: 50),
          ),
          Container(
            margin: EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  travelogueCommentModel.user.name??"",
                  style: Theme.of(context)
                      .textTheme.headline6,
                ),
                Text(travelogueCommentModel.text??"asdf",),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
