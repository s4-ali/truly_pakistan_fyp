import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile/edit_profile_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/splash_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage",style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).canvasColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),),
        actions: <Widget>[
          IconButton(
            onPressed: ()async{
              await FirebaseAuth.instance.signOut();
//              pushNewScreen(context, screen: SplashScreen(),withNavBar: false);
            },icon: Icon(Icons.exit_to_app,color: Theme.of(context).primaryColor,),),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    pushNewScreen(context,screen: EditProfileScreen(),withNavBar: false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                        Icon(Icons.arrow_forward_ios,size: 20,),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).textTheme.bodyText1.color.withAlpha(256~/3),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Privacy",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Icon(Icons.arrow_forward_ios,size: 20,),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).textTheme.bodyText1.color.withAlpha(256~/3),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("App Settings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Icon(Icons.arrow_forward_ios,size: 20,),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).textTheme.bodyText1.color.withAlpha(256~/3),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Saved Posts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Icon(Icons.arrow_forward_ios,size: 20,),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).textTheme.bodyText1.color.withAlpha(256~/3),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Notifications",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Icon(Icons.arrow_forward_ios,size: 20,),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).textTheme.bodyText1.color.withAlpha(256~/3),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Requested Products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Icon(Icons.arrow_forward_ios,size: 20,),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  color: Theme.of(context).textTheme.bodyText1.color.withAlpha(256~/3),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
