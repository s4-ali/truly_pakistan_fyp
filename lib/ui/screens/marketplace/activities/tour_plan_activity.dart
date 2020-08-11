
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/widgets/timeline_widget.dart';
import '../data.dart';
import 'checkout_activity.dart';

class TourPlanActivity extends StatelessWidget {

  final String position;
  final String path;

  const TourPlanActivity({Key key, this.position, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    String description="Hunza, the valley of dreams where the cherry blossom trees put on a spectacular show in summer, and the frost-covered mountains and icy Attabad Lake create a scene straight out of a snow globe in winter, is located in the Gilgit-Pakistan region of Pakistan. A week in the majestic Karakoram mountain ranges is enough to transform you. It offers something for everyone.";
    String recommendedGear="Water bottle\nGloves (highly recommended)\nMuffler (highly recommended)\nBeanie (highly recommended)\nHand wash/soap/sanitizer, wipes, tooth paste and all other necessities\nSun Block and Sun glasses";
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: screenWidth-(screenWidth/4),
            width: screenWidth,
            child: Stack(
              children: <Widget>[
                Hero(
                  tag:"xxx",
                  child: Image.network(path,
                    width: screenWidth,
                    height: screenWidth-(screenWidth/4),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: screenWidth,
                    color: Color(0x55000000),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Malam Jabba 2 Days Trip",
                        style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32,left: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0x22000000),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                          child: Icon(Icons.arrow_back,color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: screenWidth,
            height: screenHeight-screenWidth+(screenWidth/4),
            color: Color(0xFFEEEEEE),
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(0),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 16.0,bottom: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("12,000 Rs",style: TextStyle(color: Color(0xFF008B6A),fontSize: 20,fontWeight: FontWeight.w600),),
                      RaisedButton(
                        onPressed:(){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_)=>CheckoutActivity(position: "1",path: path,),
                            ),
                          );
                        },
                        child: Text("Book Now",style: TextStyle(fontSize: 18),),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12,horizontal: 32),
                        color: Color(0xFF008B6A),
                        textColor: Colors.white,
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Description", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(description),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Recommended Gear", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(recommendedGear),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Facilities", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("Services",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      Row(
                        children: <Widget>[
                          bubbleBox("Accommodation (3-4 persons sharing)")
                        ],
                      ),Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("Activities",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      Row(
                        children: <Widget>[
                          bubbleBox("Accommodation (3-4 persons sharing)")
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.0),
                  color: Colors.white,
                  child: Timeline(
                    children: <Widget>[
                      Container(height: 100, color: Color(0xFFeeeeee),),
                      Container(height: 50, color: Color(0xFFeeeeee),),
                      Container(height: 200, color: Color(0xFFeeeeee),),
                      Container(height: 100, color: Color(0xFFeeeeee),),
                    ],
                    indicators: <Widget>[
                      Icon(Icons.access_alarm),
                      Icon(Icons.backup),
                      Icon(Icons.accessibility_new),
                      Icon(Icons.access_alarm),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget bubbleBox(String text){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Color(0xFFEEEEEE),
      ),
      padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 16.0),
      child: Text(text),
    );
  }
}
