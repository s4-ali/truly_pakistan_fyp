import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/activities/tour_plan_activity.dart';

import '../data.dart';
import '../main.dart';

class CategoryListWidget extends StatelessWidget {

  final List<MarketPlaceItemModel> adsList;
  final String categoryTitle;

  const CategoryListWidget(
      {
        Key key,
        this.adsList,
        this.categoryTitle
      }) :super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(categoryTitle,
                  style: TextStyle(
                    color: Color(0xff008736),
                    fontSize: 38.0,
                    fontFamily: "Calibre-Semibold",
                    letterSpacing: 1.0,
                  )),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  size: 24.0,
                  color: Color(0xff008736),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MarketPlace(pageModel:null)));
                },
              )
            ],
          ),
        ),
        Container(
//          color: Colors.blue,
          height: 250.0,
          child: ListView.builder(
            itemCount: adsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,position){
              return GestureDetector(
                onTap: (){
                  pushNewScreen(context,
                      screen: TourPlanActivity(position: "_$categoryTitle$position",path: adsList[position].images[0],),
                      withNavBar: false,
                      customPageRoute: MaterialPageRoute(builder: (_)=>TourPlanActivity(position: "_$categoryTitle$position",path: adsList[position].images[0],)));
                  print("On Click $position");
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 18.0,top: 18.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Hero(
                            tag:"cover_image_$categoryTitle$position",
                            child: Image.network(adsList[position].images[0],
                                width: 200.0,height:150,fit: BoxFit.fill,),
                          ),
                          Wrap(
//                            direction: ,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Color(0x2F000000), offset: Offset(0,-4))],
                                  color: Color(0xfffbfbfb),
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                  border: Border.all(color: Colors.black12,width: 1)
                                ),
                                alignment: Alignment.bottomCenter,
                                width: 200,
                                height:65,
                                padding: EdgeInsets.all(8.0),
                                child: Stack(
                                  children: <Widget>[
                                    Text(
                                      adsList[position].title,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(adsList[position].price.toString(),
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xff008B6A)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
