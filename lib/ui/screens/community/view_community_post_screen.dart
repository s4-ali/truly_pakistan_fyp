import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/UserModel.dart';
import 'package:truly_pakistan_fyp/models/community/community_answer_model.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/providers/community/community_provider.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/data.dart';

class ViewCommunityPostScreen extends StatefulWidget {
  final CommunityPostModel communityPostModel;
  ViewCommunityPostScreen(this.communityPostModel);

  @override
  _ViewCommunityPostScreenState createState() =>
      _ViewCommunityPostScreenState();
}

class _ViewCommunityPostScreenState extends State<ViewCommunityPostScreen> {
  TextEditingController _addAnswerController;

  @override
  void initState() {
    super.initState();
    _addAnswerController=TextEditingController();
    _loadAnswers();
    _loadUserVote();
  }

  Widget _getUserSection() {
    return Container(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: (widget.communityPostModel.user.profileUrl != null &&
                        widget.communityPostModel.user.profileUrl.isNotEmpty)
                    ? CachedNetworkImage(
                        imageUrl: widget.communityPostModel.user.profileUrl,
                        fit: BoxFit.cover,
                        height: 50,
                        width: 50,
                      )
                    : Icon(
                        Icons.person,
                        size: 50,
                      ),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.communityPostModel.user.name ?? "No-Name",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      widget.communityPostModel.timeElapsed,
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .color
                              .withAlpha(180),
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "${widget.communityPostModel.totalVotes} votes",
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _getSingleMediaView() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(35),
              blurRadius: 6,
              offset: Offset(2, 6),
              spreadRadius: 0)
        ],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: widget.communityPostModel.images[0],
            width: double.infinity,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(
              Icons.error,
              color: Colors.red,
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.backgroundColor,
        centerTitle: true,
        title: Text(
          "Question",
          style: TextStyle(color: theme.primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: theme.primaryColor,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: theme.primaryColor,
            ),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, offset: Offset(0, 3), blurRadius: 3),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getUserSection(),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Text(
                    widget.communityPostModel.title,
                    style: theme.textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                  child: Text(widget.communityPostModel.description),
                ),
                if (widget.communityPostModel.images != null &&
                    widget.communityPostModel.images.length != 0)
                  _getSingleMediaView(),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                  child: Text(
                    "#Tag1 Tag2",
                    style: theme.textTheme.subtitle1,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Provider.of<CommunityProvider>(context,listen: false)
                                .addUpVoteTo(widget.communityPostModel);},
                          icon: Icon(Icons.arrow_upward),
                          iconSize: 30,
                          color: theme.primaryColor,
                        ),
                        Text(
                          "${widget.communityPostModel.totalVotes}",
                          style: TextStyle(fontSize: 16, color: theme.primaryColor),
                        ),
                        IconButton(
                          onPressed: () {
                            Provider.of<CommunityProvider>(context,listen: false)
                                .addDownVoteTo(widget.communityPostModel);
                          },
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 30,
                          color: theme.primaryColor,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:16.0),
                      child: Text("Share"),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              controller: _addAnswerController,
              onEditingComplete: ()async{
                if(_addAnswerController.text.isEmpty)return;
                var fUser=FirebaseAuth.instance.currentUser;
                UserModel user=UserModel()
                  ..name=fUser.displayName
                  ..uid=fUser.uid
                  ..profileUrl=fUser.photoURL;
                CommunityAnswerModel answer=CommunityAnswerModel()
                  ..text=_addAnswerController.text
                  ..upVotes=0
                  ..downVotes=0
                  ..votes="0"
                  ..postedAt=DateTime.now()
                  ..user=user;
                await Provider.of<CommunityProvider>(context,listen: false)
                    .addNewAnswerTo(widget.communityPostModel, answer);
                setState(() {
                  _addAnswerController.clear();
                  FocusScope.of(context).unfocus();
                });
              },
              decoration: InputDecoration(
                border: InputBorder.none, hintText: "Got an answer?",
              ),
            ),
          ),
          if (widget.communityPostModel.answers == null)
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          if (widget.communityPostModel.answers != null &&
              widget.communityPostModel.answers.length == 0)
            Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(
                child: Text("This question has no answers"),
              ),
            ),
          if (widget.communityPostModel.answers != null &&
              widget.communityPostModel.answers.length != 0)
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) {
                CommunityAnswerModel answer =
                    widget.communityPostModel.answers[index];
                return Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 16,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_upward),
                          iconSize: 30,
                          color: theme.primaryColor,
                        ),
                        Text(
                          "${answer.votes}",
                          style: TextStyle(
                              fontSize: 16, color: theme.primaryColor),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 30,
                          color: theme.primaryColor,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 16),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: theme.backgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3,
                                  offset: Offset(0, 3))
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              answer.user.name,
                              style: theme.textTheme.headline6
                                  .copyWith(color: theme.primaryColor),
                            ),
                            Text(answer.text)
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: widget.communityPostModel.answers.length,
            ),
        ],
      ),
    );
  }

  void _loadAnswers() async {
    await Provider.of<CommunityProvider>(context, listen: false)
        .loadAnswersFor(widget.communityPostModel);
    setState(() {

    });
  }

  void _loadUserVote() {
//    Provider.of<CommunityProvider>(context,listen: false)
//        .getVoteOn(widget.communityPostModel);
  }
}
