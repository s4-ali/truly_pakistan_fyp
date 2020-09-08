import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/widgets/comments_bottom_sheet.dart';
import 'package:truly_pakistan_fyp/utils.dart';

import '../profile_screen.dart';

class ViewMediaPostScreen extends StatefulWidget {
  final TraveloguePostModel traveloguePost;

  ViewMediaPostScreen(this.traveloguePost);

  @override
  _ViewMediaPostScreenState createState() => _ViewMediaPostScreenState();
}

class _ViewMediaPostScreenState extends State<ViewMediaPostScreen> {
  bool _isOptionsVisible=false;


  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() async {
    await Provider.of<TravelogueProvider>(context, listen: false)
        .loadCommentsFor(widget.traveloguePost);
//    setState(() {
//
//    });
  }

  Widget _getBackButton(){
    return Positioned(
      top: getTopPadding(context) + 16,
      left: 8.0,
      child: AnimatedOpacity(
        opacity: _isOptionsVisible?1.0:0.0,
        duration: Duration(milliseconds: 500),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getOptionsButton(){
    return Positioned(
      top: getTopPadding(context) + 16,
      right: 8.0,
      child: AnimatedOpacity(
        opacity: _isOptionsVisible?1.0:0.0,
        duration: Duration(milliseconds: 500),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoPanel() {
    return Positioned(
      bottom: 0,
      child: AnimatedOpacity(
        opacity: _isOptionsVisible?1.0:0.0,
        duration: Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getUserSection(),
              Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8,right: 8),
                child: Text(widget.traveloguePost.description,style: TextStyle(color: Colors.white),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:12.0,left: 8,right: 8),
                child: Text("Islamabad",style: TextStyle(color: Colors.white.withAlpha(200),),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:4.0,left: 8,right: 8,bottom: 8),
                child: Text("#Hiking",style: TextStyle(color: Colors.white.withAlpha(200),),),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _makeLikeButton(),
                  CommentButtonWidget(widget.traveloguePost),
                  _makeShareButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getUserSection() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0,top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: (widget.traveloguePost.user.imageUrl!=null
                    &&widget.traveloguePost.user.imageUrl.isNotEmpty) ?
                CachedNetworkImage(
                  imageUrl: widget.traveloguePost.user.imageUrl,
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ):Icon(Icons.person,size: 50,color: Colors.white,),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: ()async{
                        UserModel user=await Provider.of<UserProvider>(context,listen: false)
                            .getUserDetails(widget.traveloguePost.user);
                        pushNewScreen(context, screen: ProfileScreen(user: user,));
                      },
                      child: Text(
                        widget.traveloguePost.user.name,
                        style: Theme.of(context)
                            .textTheme.headline6
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Text(widget.traveloguePost.timeElapsed,style: TextStyle(color: Colors.white.withAlpha(180),fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),
          Icon(Icons.more_vert,color: Colors.white,)
        ],
      ),
    );
  }

  Widget _makeLikeButton() {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(widget.traveloguePost.isReacted){
            widget.traveloguePost.isReacted=false;
            widget.traveloguePost.reacts--;
            Provider.of<TravelogueProvider>(context,listen: false).removeReactionTo(widget.traveloguePost);
          }else{
            widget.traveloguePost.isReacted=true;
            widget.traveloguePost.reacts++;
            Provider.of<TravelogueProvider>(context,listen: false).addReactionTo(widget.traveloguePost);
          }
        }
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(widget.traveloguePost.isReacted?Icons.favorite:Icons.favorite_border, color: widget.traveloguePost.isReacted ? Theme.of(context).primaryColor : Colors.grey, size: 35,),
            Text("${widget.traveloguePost.reacts}", style: TextStyle(color: widget.traveloguePost.isReacted ? Theme.of(context).primaryColor : Colors.grey,fontSize: 17),)
          ],
        ),
      ),
    );
  }

  Widget _makeShareButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share, color: Colors.transparent, size: 25),
            SizedBox(width: 5,),
            Text("Share", style: TextStyle(color: Colors.transparent,fontSize: 17),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  _isOptionsVisible=!_isOptionsVisible;
                });
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: PageView(
                  children: widget.traveloguePost.images.map((imageUrl) =>
                      Center(
                        child: CachedNetworkImage(
                          imageUrl:imageUrl,
                          width: double.infinity,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      )
                  ).toList()
                )
              ),
            ),
          ),
          _getBackButton(),
          _getOptionsButton(),
          _buildInfoPanel(),
        ],
      ),
    );
  }


}

class CommentButtonWidget extends StatelessWidget {

  final TraveloguePostModel traveloguePostModel;

  const CommentButtonWidget(this.traveloguePostModel,{Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _makeCommentButton(context);
  }

  Widget _makeCommentButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showModalBottomSheet<CommentsBottomSheet>(
          isScrollControlled: true,
          context: context,
          builder: (context)
            => CommentsBottomSheet(traveloguePostModel)
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.chat, color: Colors.grey, size: 25),
              SizedBox(width: 5,),
              Text("Comment", style: TextStyle(color: Colors.grey,fontSize: 17),)
            ],
          ),
        ),
      ),
    );
  }


}

