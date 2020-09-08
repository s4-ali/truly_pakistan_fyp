import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_ui/animated_firestore_list.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/notifications/notifications_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/community/community_provider.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/community/view_community_post_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/notification/notification_widget.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/view_travelogue_screen.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    String uid=FirebaseAuth.instance.currentUser.uid;
    var query=FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("Notifications")
        .orderBy("time",descending: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notification",style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
      ),
      body: FirestoreAnimatedList(
        query: query,
        itemBuilder: (_,doc,__,index){
          var notification=NotificationModel().fromMap(doc.data());
          return InkWell(
            onTap: (){
              launchScreen(notification);
            },
            child: NotificationWidget(notification),
          );
        },
      ),
    );
  }

  void launchScreen(NotificationModel notification) async{
    if(notification.type=="0"){
      var travelogueProvider=Provider.of<TravelogueProvider>(context,listen: false);
      var travelogue=await travelogueProvider.getTravelogueById(notification.docId);
      pushNewScreen(context, screen: ViewMediaPostScreen(travelogue),withNavBar: false);
    }else if(notification.type=="1"){
      var communityProvider=Provider.of<CommunityProvider>(context,listen: false);
      var question=await communityProvider.getQuestionById(notification.docId);
      pushNewScreen(context, screen: ViewCommunityPostScreen(question),withNavBar: false);
    }else if(notification.type=="2"){
      var userProvider=Provider.of<UserProvider>(context,listen: false);
      var user=await userProvider.getUserDetails(UserModel()..uid=notification.docId);
      pushNewScreen(context, screen: ProfileScreen(user: user,),withNavBar: false);
    }
  }
}
