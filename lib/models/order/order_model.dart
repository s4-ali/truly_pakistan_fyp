import 'package:truly_pakistan_fyp/models/order/order_details_model.dart';
import 'package:truly_pakistan_fyp/models/order/shipping_details_model.dart';

class OrderModel{
  OrderDetailsModel orderDetails;
  ShippingDetailsModel shippingDetails;
  int status=0;
  Map<String,dynamic> toMap(){
    Map<String,dynamic> map=Map();
    map["orderDetails"]=orderDetails.toMap();
    map["shippingDetails"]=shippingDetails.toMap();
    map["status"]=status;
    return map;
  }
}