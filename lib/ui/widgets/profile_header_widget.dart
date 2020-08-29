import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/settings_screen.dart';

import 'back_arrow_widget.dart';

class ProfileHeaderWidget implements SliverPersistentHeaderDelegate {

  final UserModel userModel;

  ProfileHeaderWidget(this.userModel);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    print(shrinkOffset);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width*0.75,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.only(bottom: 60),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl:userModel.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width*0.75,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Theme.of(context).canvasColor, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp
                          )
                      ),
                    ),
                    Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("24K",style: TextStyle(fontSize: 16),),
                              Text("Followers"),
                            ],
                          ),
                          SizedBox(width: 10,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("1287",style: TextStyle(fontSize: 16),),
                              Text("Following"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: (MediaQuery.of(context).size.width*.37)+5,
                  width: (MediaQuery.of(context).size.width*.37)+5,
//                    margin: EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.circular(125),
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: CachedNetworkImage(
                        height: (MediaQuery.of(context).size.width*.37),
                        width: (MediaQuery.of(context).size.width*.37),
                        imageUrl: userModel.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              if(!userModel.isCurrentUser)BackArrowWidget()
              else Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32,right: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Color(0x22000000),
                      ),
                      child: InkWell(
                        onTap: (){
                          pushNewScreen(context, screen: SettingsScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                          child: Icon(Icons.settings,color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom:16.0),
              child: Center(
                child: Text("Asfar Ali",style: Theme.of(context).textTheme.headline5
                    .copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if(userModel.isCurrentUser) Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        boxShadow: [BoxShadow(color: Colors.black12,
                            blurRadius: 3,offset: Offset(0,3))],
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: Center(child: Text("Follow",style: TextStyle(color: Theme.of(context).canvasColor,fontWeight: FontWeight.bold),),),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    child: Center(child: Text("Message",style: TextStyle(fontWeight: FontWeight.bold),),),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(userModel.bio,textAlign: TextAlign.center,),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24,right: 24),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text("Travelogues",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4,),
                        Container(height: 5,color: Theme.of(context).primaryColor,width: double.infinity,),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text("Questions",style: TextStyle(fontSize: 16),),
                        SizedBox(height: 6,),
                        Container(height: 3,color: Colors.black26,width: double.infinity,),
                      ],
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 450;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;


}
