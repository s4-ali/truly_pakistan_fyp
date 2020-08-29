import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/ui/widgets/back_arrow_widget.dart';

import '../settings_screen.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userModel;

  EditProfileScreen(this.userModel,{Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl:widget.userModel.imageUrlCover,
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
                                Text((widget.userModel.totalFollowers??"0").toString(),style: TextStyle(fontSize: 16),),
                                Text("Followers"),
                              ],
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text((widget.userModel.totalFollowing??"0").toString(),style: TextStyle(fontSize: 16),),
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
                          imageUrl: widget.userModel.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                if(!widget.userModel.isCurrentUser)BackArrowWidget()
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
                  child: Text(widget.userModel.name??"NA",style: Theme.of(context).textTheme.headline5
                      .copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if(widget.userModel.isCurrentUser) Row(
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
                child: Text(widget.userModel.bio,textAlign: TextAlign.center,),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color:Colors.black26,offset: Offset(1,3),blurRadius: 3)]
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Travelogues",style: TextStyle(fontSize: 17),),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color:Colors.black26,offset: Offset(1,3),blurRadius: 3)]
                ),
                margin: EdgeInsets.only(top: 16,left: 16,right: 16),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Questions",style: TextStyle(fontSize: 17),),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

  }
}