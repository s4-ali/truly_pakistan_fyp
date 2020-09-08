import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/community/view_community_post_screen.dart';

class CommunityPostWidget extends StatelessWidget {
  final CommunityPostModel communityPostModel;
  CommunityPostWidget(this.communityPostModel);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreen(context, screen: ViewCommunityPostScreen(communityPostModel),withNavBar: false);
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(1,3),blurRadius: 3,spreadRadius: 0)],
        ),
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: (communityPostModel.user.imageUrl!=null
                      &&communityPostModel.user.imageUrl.isNotEmpty) ?
                  CachedNetworkImage(
                    imageUrl: communityPostModel.user.imageUrl,
                    fit: BoxFit.cover,
                    height: 50,
                    width: 50,
                  ):Icon(Icons.person,size: 50,),
                ),
                SizedBox(width: 8,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        communityPostModel.title,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      if(communityPostModel.tags!=null&&communityPostModel.tags.length>0)Text(communityPostModel.tags[0],style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("${communityPostModel.totalVotes} votes | ${communityPostModel.totalAnswers} answers"),
                Text("${communityPostModel.timeElapsed} "),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
