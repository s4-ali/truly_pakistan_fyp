
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/imageviewer_screen.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/activities/checkout_activity.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/widgets/timeline_widget.dart';

class TourPlanActivity extends StatelessWidget {

  final MarketPlaceItemModel product;

  const TourPlanActivity(this.product,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
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
                  tag:product.images[0],
                  child: GestureDetector(
                    onTap: (){
                      pushNewScreen(context, screen: ImageViewerScreen(product.images),withNavBar: false);
                    },
                    child: CachedNetworkImage(
                      imageUrl: product.images[0],
                      width: screenWidth,
                      height: screenWidth-(screenWidth/4),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: screenWidth,
                    color: Color(0x55000000),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.title,
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
            color: Theme.of(context).canvasColor,
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
                      Text("${product.price} Rs",style: TextStyle(color: Color(0xFF008B6A),fontSize: 20,fontWeight: FontWeight.w600),),
                      RaisedButton(
                        onPressed:(){
                          pushNewScreen(context, screen: CheckoutActivity(product),withNavBar: false);
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
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Description", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text(product.description),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 16.0),
                  margin: EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if(product.activities!=null)Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("Activities",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      if(product.activities!=null)Wrap(
                        direction: Axis.horizontal,
                        children: product.activities.map((e) => Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: bubbleBox(e, context),
                        )).toList(),
                      ),
                      if(product.activities!=null)Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: Text("Services",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                      ),
                      if(product.activities!=null)Wrap(
                        direction: Axis.horizontal,
                        children: product.servicesAvailable.map((e) => Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: bubbleBox(e, context),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
                if(product.activities!=null)Container(
                  margin: EdgeInsets.only(top: 16.0),
                  color: Theme.of(context).cardColor,
                  child: Timeline(
                    children: product.day.map((e) => Container(
                      color: Colors.black12,
                      padding: EdgeInsets.all(16),
                      child: Text(e),
                    )).toList(),
                    indicators: product.day.map((e) => Text("Day ${product.day.indexOf(e)+1}")).toList(),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }

  Widget bubbleBox(String text,BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.black12,
      ),
      padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 16.0),
      child: Text(text),
    );
  }
}
