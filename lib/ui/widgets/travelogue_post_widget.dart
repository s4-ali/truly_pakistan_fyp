import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/view_travelogue_screen.dart';
import 'package:truly_pakistan_fyp/ui/widgets/multi_image_widget.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class TraveloguePostWidget extends StatefulWidget {

  final TraveloguePostModel traveloguePost;

  const TraveloguePostWidget(this.traveloguePost, {Key key}) : super(key: key);

  @override
  _TraveloguePostWidgetState createState() => _TraveloguePostWidgetState();
}

class _TraveloguePostWidgetState extends State<TraveloguePostWidget> {

  bool isActive=true;

  Widget _getMediaView() {
    if(widget.traveloguePost.images==null||widget.traveloguePost.images.isEmpty)return Container();
    if(widget.traveloguePost.images.length==1)return _getSingleMediaView();
    else return _getMultiMediaView();
  }

  Widget _getUserSection() {
    print("User:${widget.traveloguePost.user.toString()}");
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: (
                    widget.traveloguePost.user!=null&&
                    widget.traveloguePost.user.imageUrl!=null
                    &&widget.traveloguePost.user.imageUrl.isNotEmpty) ?
                CachedNetworkImage(
                  imageUrl: widget.traveloguePost.user.imageUrl,
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ):Icon(Icons.person,size: 50,),
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
                        pushNewScreen(context, screen: ProfileScreen(user: user,),withNavBar: false);
                      },
                      child: Text(
                        widget.traveloguePost.user==null?"NA":widget.traveloguePost.user.name??"NA",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Text(widget.traveloguePost.timeElapsed,style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color.withAlpha(180),fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: (){
              var options=[""];
              if(FirebaseAuth.instance.currentUser.uid
                  == widget.traveloguePost.user.uid)
                options=["Edit","Delete"];
              else
                options=["Report","Save"];
              showCustomDialog(context, "Options", options,(index){
                if(FirebaseAuth.instance.currentUser.uid
                    == widget.traveloguePost.user.uid)
                  print("Delete");
                else
                  print("Report");
              });
            },
            icon:Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }

  Widget _getTextSection() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
      child: Text(widget.traveloguePost.description),
    );
  }

  Widget _getActionSection() {
    return Container(
      color: Colors.black.withAlpha(5),
      margin: EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          Container(height: 0.5,width: double.infinity,color: Colors.black38,),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap:(){
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
                        });
                      },
                      child: Icon(Icons.favorite,color: widget.traveloguePost.isReacted?Theme.of(context).primaryColor:Theme.of(context).iconTheme.color,),
                    ),
                    SizedBox(width: 4,),
                    Text("${widget.traveloguePost.reacts??0}"),
                    SizedBox(width: 16,),
                    Icon(Icons.comment),
                    SizedBox(width: 4,),
                    Text("${widget.traveloguePost.totalComments??0}"),
                  ],
                ),
                Icon(Icons.share,color: Colors.transparent,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSingleMediaView() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0,bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(35),blurRadius: 6,offset: Offset(2,5))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.traveloguePost.images[0],
          width: double.infinity,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
        )
      ),
    );
  }

  Widget _getMultiMediaView() {
    return MultiImageWidget(images: widget.traveloguePost.images,);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 3,offset: Offset(0,3))]
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              pushNewScreen(context, screen: ViewMediaPostScreen(widget.traveloguePost),withNavBar: false);
            },
            child: _getMediaView(),
          ),
          _getUserSection(),
          if(widget.traveloguePost.description!=null
            &&widget.traveloguePost.description.isNotEmpty)
            GestureDetector(
              onTap: (){
                if(widget.traveloguePost.images!=null&&widget.traveloguePost.images.isNotEmpty)
                pushNewScreen(context, screen: ViewMediaPostScreen(widget.traveloguePost),withNavBar: false);
              },
              child: _getTextSection(),
            ),
          _getActionSection(),
        ],
      ),
    );
  }
}
