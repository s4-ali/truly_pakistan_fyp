import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class UsersTravelogueScreen extends StatefulWidget {
  final UserModel user;

  const UsersTravelogueScreen({Key key, this.user}) : super(key: key);
  @override
  _UsersTravelogueScreenState createState() => _UsersTravelogueScreenState();
}

class _UsersTravelogueScreenState extends State<UsersTravelogueScreen> {

  List<TraveloguePostModel> _travelogues;

  @override
  void initState() {
    super.initState();
    loadTravelogues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.name}'s Travelogues",style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
      ),
      body: _travelogues==null?Center(child: CircularProgressIndicator(),)
          :_travelogues.length>0?ListView.builder(
        itemBuilder: (_,index){
          return TraveloguePostWidget(
            _travelogues[index],
          );
        },
        itemCount: _travelogues.length,
      ):Center(child: Text("${widget.user.name} does not have any travelogues"),),
    );
  }

  void loadTravelogues() async{
    _travelogues = await Provider.of<TravelogueProvider>(context,listen: false).getTraveloguePostsByUser(widget.user);
    setState(() {

    });
  }
}
