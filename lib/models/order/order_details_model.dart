import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';

class OrderDetailsModel{
  MarketPlaceItemModel productDetails;
  int price;
  String quantity;
  int totalPrice;
  Timestamp createdAt;
  UserModel user;

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    map["productDetails"]=productDetails.toMap();
    map["price"]=price;
    map["quantity"]=quantity;
    map["totalPrice"]=totalPrice;
    map["createdAt"]=FieldValue.serverTimestamp();
    map["user"]=user.toMapBasic();
    return map;
  }
}