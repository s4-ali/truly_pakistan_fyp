import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile_screen.dart';

class FollowTileWidget extends StatelessWidget {

  final UserModel user;

  FollowTileWidget({this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        pushNewScreen(context,screen: ProfileScreen(user: user,));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8,left: 16,right: 16),
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(16)
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: CachedNetworkImage(
                imageUrl: user.imageUrl,
                height: 40,
                width: 40,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 8,),
            Text(user.name,style: Theme.of(context).textTheme.headline6,),
          ],
        )
      ),
    );
  }
}
