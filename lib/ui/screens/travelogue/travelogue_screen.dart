import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/providers/travelogue/travelogue_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/data.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/add_travelogue_screen.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class TravelogueScreen extends StatefulWidget {
  @override
  _TravelogueScreenState createState() => _TravelogueScreenState();
}

class _TravelogueScreenState extends State<TravelogueScreen> {
  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      appBar: AppBar(
        title: Text("TrulyPakistan",style: TextStyle(color: Theme.of(context).primaryColor),),
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: (){
              print("onPressed");
              pushNewScreen(context, screen: AddTravelogueScreen(),withNavBar: false);
          },icon: Icon(Icons.add,color: Theme.of(context).primaryColor,),),
        ],
      ),
      body: Consumer<TravelogueProvider>(
        builder: (_,travelogueProvider,__){
          return ListView.builder(
            itemBuilder: (_,index){
              return TraveloguePostWidget(
                  travelogueProvider.getTraveloguePosts()[index],
              );
            },
            itemCount: travelogueProvider.getTraveloguePosts().length,
          );
        },
      ),
    );
  }
}
