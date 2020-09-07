import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/community/community_post_model.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/models/travelogue/travelogue_post_model.dart';
import 'package:truly_pakistan_fyp/ui/widgets/community_post_widget.dart';
import 'package:truly_pakistan_fyp/ui/widgets/travelogue_post_widget.dart';

class ProductSearchResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid=FirebaseAuth.instance.currentUser.uid;
    var snap=FirebaseFirestore
        .instance
        .collection("users")
        .doc(uid)
        .collection("QueryResults")
        .doc("Product")
        .snapshots();
    return StreamBuilder(
      stream: snap,
      builder: (_,result){
        List<MarketPlaceItemModel> products;
        if(result.connectionState==ConnectionState.active) {
          var doc = result.data as DocumentSnapshot;
          products=extractProducts(doc.data());
          return ListView.builder(
            itemCount: products.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (_,index){

              return Padding(
                padding: EdgeInsets.only(left: 16.0,top: 16.0,right: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Column(
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: products[index].images[0],
                        width: MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.width-32,
                        fit: BoxFit.fill,
                      ),
                      Wrap(
                        children:<Widget>[
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0,3),blurRadius: 3)],
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
                            ),
                            alignment: Alignment.bottomCenter,
                            width: MediaQuery.of(context).size.width,
                            height:75,
                            padding: EdgeInsets.all(12.0),
                            child: Stack(
                              children: <Widget>[
                                Text(
                                  products[index].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    products[index].price.toString(),
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
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  List<MarketPlaceItemModel> extractProducts(Map<String, dynamic> data) {
    List<MarketPlaceItemModel> products=List();
    if(data["hits"]!=null) {
      for(var s in data["hits"] as List<dynamic>){
        products.add(MarketPlaceItemModel().fromMap(s));
      }
    }
    return products;
  }
}
