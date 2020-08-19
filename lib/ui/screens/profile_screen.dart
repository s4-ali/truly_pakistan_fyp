import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/UserModel.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/screens/follow_list_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/settings_screen.dart';
import 'package:truly_pakistan_fyp/ui/widgets/back_arrow_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';
import 'package:truly_pakistan_fyp/utils.dart';

import 'marketplace/data.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userModel;
  final bool isCurrentUser;

  const ProfileScreen({Key key, this.userModel, this.isCurrentUser=false}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width*0.75,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl:adModels[0].imgUrl,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width*0.75,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
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
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 75,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 4,offset: Offset(1,4)),]
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            pushNewScreen(context, screen: FollowListScreen());
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("24K",style: TextStyle(fontSize: 16),),
                              Text("Followers"),
                            ],
                          ),
                        ),
                        Text("Asfar Ali",
                          style: Theme.of(context)
                              .textTheme.headline6
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        GestureDetector(
                          onTap: (){
                            pushNewScreen(context, screen: FollowListScreen(),withNavBar: false);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("1925",style: TextStyle(fontSize: 16),),
                              Text("Following"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 125,
                    width: 125,
                    margin: EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(125),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(125),
                        child: CachedNetworkImage(
                          height: 120,
                          width: 120,
                          imageUrl: adModels[4].imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                if(!widget.isCurrentUser)BackArrowWidget()
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
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height
                -(MediaQuery.of(context).size.width*0.75)
                -MediaQuery.of(context).padding.bottom-56,
            child: ListView(
              children: <Widget>[
                if(!widget.isCurrentUser) Row(
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
                  child: Text(bio,textAlign: TextAlign.center,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("Travelogues",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4,),
                          Container(height: 5,color: Theme.of(context).primaryColor,width: 100,),
                        ],
                      ),
                      SizedBox(width: 16,),
                      Text("Questions",style: TextStyle(fontSize: 16),),
                    ],
                  ),
                ),
                TraveloguePostWidget(images: [adModels[6].imgUrl],)
              ],
            ),
          ),
        ],
      )
    );
  }
}
