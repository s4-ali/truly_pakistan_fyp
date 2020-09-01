import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/chat/chat_room_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/chat/chat_provider.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/chat/chat_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/community/users_question_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/profile/edit_profile_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/settings_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/users_travelogue_screen.dart';
import 'package:truly_pakistan_fyp/ui/widgets/back_arrow_widget.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel user;

  const ProfileScreen({Key key, this.user}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loadingFollowing = false;
  bool _isCurrentUserFollowing = false;
  bool _isChatLoading=false;
  UserProvider _userProvider;

  @override
  void initState() {
    _userProvider=Provider.of<UserProvider>(context,listen: false);
    print("currentUser:${_userProvider.getCurrentUser().uid}");
    print("widgetUser:${widget.user.uid}");
    widget.user.isCurrentUser=_userProvider.getCurrentUser().uid==widget.user.uid;
    if (!widget.user.isCurrentUser) {
      _loadingFollowing = true;
      loadIsCurrentUserFollowing(widget.user.uid);
    }
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
            height: MediaQuery.of(context).size.width * 0.75,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 60),
                    child: widget.user.imageUrlCover != null
                        ? CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: widget.user.imageUrlCover,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.75,
                          )
                        : Image.asset(
                            "name",
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width * 0.75,
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
                                colors: [
                                  Theme.of(context).canvasColor,
                                  Colors.transparent
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp)),
                      ),
                      Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  (widget.user.totalFollowers ?? "0")
                                      .toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text("Followers"),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  (widget.user.totalFollowing ?? "0")
                                      .toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
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
                    height: (MediaQuery.of(context).size.width * .37) + 5,
                    width: (MediaQuery.of(context).size.width * .37) + 5,
//                    margin: EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius: BorderRadius.circular(125),
                    ),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: widget.user.imageUrl != null
                            ? CachedNetworkImage(
                                height:
                                    (MediaQuery.of(context).size.width * .37),
                                width:
                                    (MediaQuery.of(context).size.width * .37),
                                imageUrl: widget.user.imageUrl,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                "name",
                                height:
                                    (MediaQuery.of(context).size.width * .37),
                                width:
                                    (MediaQuery.of(context).size.width * .37),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ),
                ),
                if (!widget.user.isCurrentUser)
                  BackArrowWidget()
                else
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 32, right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x22000000),
                          ),
                          child: InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (widget.user.isCurrentUser)
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: (32.0 + 25.0 + 24.0), right: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Color(0x22000000),
                          ),
                          child: InkWell(
                            onTap: () {
                              pushNewScreen(context,
                                  screen: EditProfileScreen(),
                                  withNavBar: false);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 25,
                              ),
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
              Center(
                child: Text(
                  widget.user.name ?? "NA",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              if (!widget.user.isCurrentUser)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: ()async{
                            if(_isCurrentUserFollowing) {
                              setState(() {
                                _loadingFollowing=true;
                              });
                              var res=await _userProvider.unFollowUser(widget.user);
                              if(res==null){
                                setState(() {
                                  _loadingFollowing=false;
                                  _isCurrentUserFollowing=false;
                                  widget.user.totalFollowers--;
                                });
                              }
                            }
                            else {
                              setState(() {
                                _loadingFollowing=true;
                              });
                              var res=await _userProvider.followUser(widget.user);
                              if(res==null){
                                setState(() {
                                  _loadingFollowing=false;
                                  _isCurrentUserFollowing=true;
                                  widget.user.totalFollowers++;
                                });
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: _isCurrentUserFollowing?Theme.of(context).cardColor:Theme.of(context).primaryColor,
                                boxShadow: [
                                  if(!_isCurrentUserFollowing)BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 3,
                                      offset: Offset(0, 3))
                                ],
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            child: Center(
                              child: _loadingFollowing?
                              SizedBox(
                                height: 19,
                                width: 19,
                                child: CircularProgressIndicator(),
                              ) : Text(
                                _isCurrentUserFollowing?"Unfollow":"Follow",
                                style: _isCurrentUserFollowing? TextStyle(fontWeight: FontWeight.bold) : TextStyle(
                                  color: Theme.of(context).canvasColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: GestureDetector(
                          onTap: ()async{
                            setState(() {
                              _isChatLoading=true;
                            });
                            var currentUser=Provider.of<UserProvider>(context,listen: false).getCurrentUser();
                            var chatProvider= Provider.of<ChatProvider>(context,listen: false)..currentUser=currentUser;
                            var res=await chatProvider.getChatWith(widget.user);
                            setState(() {
                              _isChatLoading=false;
                            });
                            if(res is ChatRoomModel){
                              pushNewScreen(context, screen: ChatScreen(res),withNavBar: false);
                            }else{
                              shortToast("Failed to create room with ${widget.user.name}", context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: double.infinity,
                            child: Center(
                              child: _isChatLoading?SizedBox(
                                height: 19,
                                width: 19,
                                child: CircularProgressIndicator(),) :
                              Text(
                                "Message",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.user.bio ?? "",
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: (){
                  pushNewScreen(context, screen: UsersTravelogueScreen(user: widget.user,),withNavBar: false);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1, 3),
                            blurRadius: 3)
                      ]),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Travelogues",
                        style: TextStyle(fontSize: 17),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (){
                  pushNewScreen(context, screen: UsersQuestionScreen(user: widget.user,),withNavBar: false);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(1, 3),
                            blurRadius: 3)
                      ]),
                  margin: EdgeInsets.only(top: 16, left: 16, right: 16),
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Questions",
                        style: TextStyle(fontSize: 17),
                      ),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void loadIsCurrentUserFollowing(String uid) async {
    _isCurrentUserFollowing =
        await _userProvider.isCurrentUserFollowing(uid);
    setState(() {
      _loadingFollowing = false;
    });
  }
}
