import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/view_media_post_screen.dart';

class TraveloguePostWidget extends StatefulWidget {

  final List<String> images;

  const TraveloguePostWidget({Key key, this.images}) : super(key: key);

  @override
  _TraveloguePostWidgetState createState() => _TraveloguePostWidgetState();
}

class _TraveloguePostWidgetState extends State<TraveloguePostWidget> {

  bool isActive=true;

  Widget getMediaView() {
    if(widget.images.isEmpty)return Container();
    if(widget.images.length==1)return getSingleMediaView();
    else return getMultiMediaView();
  }

  Widget getUserSection() {
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
                child: Image.network("https://picsum.photos/seed/picsum/200/200", height: 50.0, width: 50.0,),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Asfar Ali",style: Theme.of(context).textTheme.headline6,),
                    Text("1 hour ago",style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color.withAlpha(180),fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),
          Icon(Icons.more_vert)
        ],
      ),
    );
  }

  Widget getTextSection() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0),
      child: Text("Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim."),
    );
  }

  Widget getActionSection() {
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
                    Icon(Icons.favorite),
                    SizedBox(width: 4,),
                    Text("123"),
                    SizedBox(width: 16,),
                    Icon(Icons.comment),
                    SizedBox(width: 4,),
                    Text("21"),
                  ],
                ),
                Icon(Icons.share),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getBottomPadding(){
    return Container(width: double.infinity,height: 16,color: Colors.black26,);
  }

  Widget getSingleMediaView() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0,bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(35),blurRadius: 6,offset: Offset(2,5))],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          imageUrl: widget.images[0],
          width: double.infinity,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
        )
      ),
    );
  }

  Widget getMultiMediaView() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        pushNewScreen(context, screen: ViewMediaPostScreen(),withNavBar: false);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 3,offset: Offset(0,3))]
        ),
        child: Column(
          children: <Widget>[
            getMediaView(),
            getUserSection(),
            getTextSection(),
            getActionSection(),
//            getBottomPadding(),
          ],
        ),
      ),
    );
  }


  Widget makeFeed({userName, userImage, feedTime, feedText, feedImage,String votes}) {
    return Container(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            feedImage != '' ?
            Container(
              height: 200,
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 2,spreadRadius: 2,offset: Offset(1,1)),],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(feedImage),
                      fit: BoxFit.cover
                  )
              ),
            ) : Container(),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(userImage),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(userName, style: TextStyle(color: Colors.grey[900], fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                        SizedBox(height: 3,),
                        Text(feedTime, style: TextStyle(fontSize: 15, color: Colors.grey),),
                      ],
                    )
                  ],
                ),
//              IconButton(
//                icon: Icon(Icons.more_horiz, size: 30, color: Colors.grey[600],),
//                onPressed: () {},
//              )
              ],
            ),
            Divider(),
            Text(feedText, style: TextStyle(fontSize: 15, color: Colors.grey[800], height: 1.5, letterSpacing: .7),),
            Divider(),
            Text(votes, style: TextStyle(fontSize: 15, color: Colors.grey[800]),),
            SizedBox(height: 10,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(20),
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  makeLikeButton(),
                  makeCommentButton(),
                  makeShareButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget makeLikeButton() {
    return GestureDetector(
      onTap: (){
        setState(() {
          isActive=!isActive;
        }
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.keyboard_arrow_up, color: isActive ? Theme.of(context).primaryColor : Colors.grey, size: 25,),
          Text("Upvote", style: TextStyle(color: isActive ? Theme.of(context).primaryColor : Colors.grey),)
        ],
      ),
    );

  }
  Widget makeCommentButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.chat, color: Colors.grey, size: 18),
            SizedBox(width: 5,),
            Text("Comment", style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
  Widget makeShareButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share, color: Colors.grey, size: 18),
            SizedBox(width: 5,),
            Text("Share", style: TextStyle(color: Colors.grey),)
          ],
        ),
      ),
    );
  }
}
