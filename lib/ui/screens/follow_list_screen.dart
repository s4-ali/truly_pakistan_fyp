import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/widgets/follow_tile_widget.dart';

class FollowListScreen extends StatefulWidget {
  @override
  _FollowListScreenState createState() => _FollowListScreenState();
}

class _FollowListScreenState extends State<FollowListScreen> {

  List<UserModel> _usersList=List();

  @override
  void initState() {
    var user=UserModel();
    user.name="Asfar";
    user.imageUrl=imageUrl;
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
    _usersList.add(user);
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
}
