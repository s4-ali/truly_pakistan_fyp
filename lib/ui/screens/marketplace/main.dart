import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/widgets/category_list_widget.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/widgets/featured_list_widget.dart';
import 'data.dart';
import 'dart:math';

import 'models/page_model.dart';

//void main() => runApp(MaterialApp(
//      home: MyApp(),
//      debugShowCheckedModeBanner: false,
//    ));

class MarketPlace extends StatefulWidget {
  final PageModel pageModel;

  const MarketPlace({Key key, this.pageModel}) : super(key: key);

  @override
  _MarketPlaceState createState() => new _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {

  ScrollController scrollController;

  void scrollListener(){
    print("devicePixelRatio:${window.devicePixelRatio}");
    print("Position:${scrollController.position.pixels}");
  }

  @override
  Widget build(BuildContext context) {

    scrollController=ScrollController();
    scrollController.addListener(scrollListener);

    AppBar appBar=AppBar(
      title: Text("MarketPlace"),
      centerTitle: true,
      backgroundColor:Color(0xFF008736),
      actions: <Widget>[
        IconButton(
          onPressed: (){
            //TODO:Open Shopping Cart
          },
          icon: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),)
      ],
    );

    return Scaffold(
      backgroundColor: Color(0xffffffff),
//      backgroundColor: Color(0xffe8e8e8),
//      appBar: appBar,
      body: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([

                  Container(
                    padding: EdgeInsets.only(top: 25, right: 20, left: 20, bottom: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text("Marketplace",style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1),),
                        ),
                        SizedBox(width: 20,),
//                        Icon(Icons.more_vert, color: Colors.black, size: 30,)
                      ],
                    ),
                  ),
                  FeatureListWidget(title: "Featured",adModels: widget.pageModel.featuredItems,),
                ]),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context,position){
                  return CategoryListWidget(
                    categoryTitle: widget.pageModel.categories[position].categoryTitle,
                    adsList: widget.pageModel.categories[position].categoryAds,
                  );
                },childCount: widget.pageModel.categories.length)
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                 Padding(
                    padding: const EdgeInsets.only(left:20.0,top: 8,bottom: 16),
                    child: Text("All Items",
                        style: TextStyle(
                          color: Color(0xff008736),
                          fontSize: 38.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                  ),
                ]),
              ),
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 210,
                childAspectRatio: .75,
              ),
              delegate: SliverChildBuilderDelegate(
                  (context,position){
                    return Padding(
                      padding: EdgeInsets.only(left: 6.0,right: 6.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Column(
                          children: <Widget>[
                            Image.network(adModels[position].imgUrl,
                              height:150,fit: BoxFit.fill,),
                            Wrap(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0,-4),blurRadius: 3)],
                                    color: Color(0xfffbfbfb),
                                    border: Border.all(color: Colors.black12,width: 1),
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                                  ),
                                  alignment: Alignment.bottomCenter,
                                //  width: screenWidth/2-padding,
                                  height:75,
                                  padding: EdgeInsets.all(12.0),
                                  child: Stack(
                                    children: <Widget>[
                                      Text(
                                        adModels[position].title,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(adModels[position].price,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xff008736)
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
                    );
                  },
                childCount: adModels.length,
              ),
            )
            ],
          ),
    );

  }
}

