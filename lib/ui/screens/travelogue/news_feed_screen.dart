import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/ui/screens/travelogue/add_media_post_screen.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
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
              pushNewScreen(context, screen: AddMediaPostScreen(),withNavBar: false);
          },icon: Icon(Icons.add,color: Theme.of(context).primaryColor,),),
        ],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            TraveloguePostWidget(
              images: ["https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5d35eacaf1176b0008974b54%2F0x0.jpg%3FcropX1%3D790%26cropX2%3D5350%26cropY1%3D784%26cropY2%3D3349"],
            ),
            TraveloguePostWidget(
              images: ["https://thumbor.forbes.com/thumbor/fit-in/1200x0/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5d35eacaf1176b0008974b54%2F0x0.jpg%3FcropX1%3D790%26cropX2%3D5350%26cropY1%3D784%26cropY2%3D3349"],
            ),
          ],
        ),
      ),
    );
  }
}
