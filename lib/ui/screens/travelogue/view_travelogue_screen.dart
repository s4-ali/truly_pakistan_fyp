import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/data.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class ViewMediaPostScreen extends StatefulWidget {
  @override
  _ViewMediaPostScreenState createState() => _ViewMediaPostScreenState();
}

class _ViewMediaPostScreenState extends State<ViewMediaPostScreen> {
  bool _isOptionsVisible=false;
  bool _isActive=false;

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
            color: Colors.black87,
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
              getUserSection(),
              Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8,right: 8),
                child: Text(loremIpsum,style: TextStyle(color: Colors.white),),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  makeLikeButton(),
                  makeCommentButton(),
                  makeShareButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget getUserSection() {
    return Container(
      margin: EdgeInsets.only(left: 8.0, right: 8.0,top: 16),
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
                    Text("Asfar Ali",style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold),),
                    Text("1 hour ago",style: TextStyle(color: Colors.white.withAlpha(180),fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget makeLikeButton() {
    return GestureDetector(
      onTap: (){
        setState(() {
          _isActive=!_isActive;
        }
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.keyboard_arrow_up, color: _isActive ? Theme.of(context).primaryColor : Colors.grey, size: 35,),
            Text("Upvote", style: TextStyle(color: _isActive ? Theme.of(context).primaryColor : Colors.grey,fontSize: 17),)
          ],
        ),
      ),
    );

  }
  Widget makeCommentButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
    );
  }
  Widget makeShareButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.share, color: Colors.grey, size: 25),
            SizedBox(width: 5,),
            Text("Share", style: TextStyle(color: Colors.grey,fontSize: 17),)
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
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl:adModels[1].imgUrl,
                    width: double.infinity,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
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
