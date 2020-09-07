import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';

class ItemsListWidget extends StatelessWidget {

  final List<MarketPlaceItemModel> adsList;
  final double height;

  const ItemsListWidget({Key key, this.adsList, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth=MediaQuery.of(context).size.width;
    final padding=12;
    return Container(
      height: height,
      child: Column(
        children: <Widget>[
          ListView.builder(
            itemCount: adsList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (ctx,position){
              return Padding(
                padding: EdgeInsets.only(left: 12.0,top: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Column(
                    children: <Widget>[
                      Image.network(adsList[position].images[0],
                        width: screenWidth/2-padding,height:150,fit: BoxFit.fill,),
                      Wrap(
//                            direction: ,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Color(0x2F000000), offset: Offset(0,-4))],
                              color: Color(0xFF222233),
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                            ),
                            alignment: Alignment.bottomCenter,
                            width: screenWidth/2-padding,
                            height:75,
                            padding: EdgeInsets.all(12.0),
                            child: Stack(
                              children: <Widget>[
                                Text(
                                  adsList[position].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(adsList[position].price.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff28B94A)
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
            physics: ClampingScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
