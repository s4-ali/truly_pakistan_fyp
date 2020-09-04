import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/widgets/follow_tile_widget.dart';

class FollowListScreen extends StatefulWidget {
  final UserModel user;
  final bool showFollowings;

  FollowListScreen(this.user, {this.showFollowings=false});

  @override
  _FollowListScreenState createState() => _FollowListScreenState();
}

class _FollowListScreenState extends State<FollowListScreen> {

  List<UserModel> _usersList=List();

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Theme.of(context).textTheme.headline6.color,),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text("Followers",style: TextStyle(color: Theme.of(context).primaryColor),),
          backgroundColor: Theme.of(context).cardColor,
          elevation: 0,
        ),
      body: ListView.builder(
        itemBuilder: (_,index){
          return FollowTileWidget(user: _usersList[index],);
        },
        itemCount: _usersList.length,
      )
    );
  }

  void loadUsers()async {
    var users;
    if(widget.showFollowings)
      users=await Provider.of<UserProvider>(context,listen: false).getFollowingsOf(widget.user);
    else
      users=await Provider.of<UserProvider>(context,listen: false).getFollowersOf(widget.user);
    setState(() {
      _usersList.clear();
      _usersList.addAll(users);
    });
  }
}
