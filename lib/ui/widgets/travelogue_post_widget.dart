import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/view_travelogue_screen.dart';

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
                child: (widget.traveloguePost.user.profileUrl!=null
                    &&widget.traveloguePost.user.profileUrl.isNotEmpty) ?
                CachedNetworkImage(
                  imageUrl: widget.traveloguePost.user.profileUrl,
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
                    Text(widget.traveloguePost.user.name,style: Theme.of(context).textTheme.headline6,),
                    Text(widget.traveloguePost.timeElapsed,style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color.withAlpha(180),fontSize: 12),),
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
                    Icon(Icons.favorite),
                    SizedBox(width: 4,),
                    Text("${widget.traveloguePost.reacts??0}"),
                    SizedBox(width: 16,),
                    Icon(Icons.comment),
                    SizedBox(width: 4,),
                    Text("${widget.traveloguePost.totalComments??0}"),
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
    return _getSingleMediaView();
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
            _getMediaView(),
            _getUserSection(),
            if(widget.traveloguePost.description!=null
              &&widget.traveloguePost.description.isNotEmpty)
              _getTextSection(),
            _getActionSection(),
          ],
        ),
      ),
    );
  }
}
