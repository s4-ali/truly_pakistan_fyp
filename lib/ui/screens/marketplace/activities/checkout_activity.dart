import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:truly_pakistan_fyp/models/marketplace/marketplace_item_model.dart';
import 'package:truly_pakistan_fyp/models/order/order_details_model.dart';
import 'package:truly_pakistan_fyp/models/order/order_model.dart';
import 'package:truly_pakistan_fyp/models/order/shipping_details_model.dart';
import 'package:truly_pakistan_fyp/models/user_model.dart';
import 'package:truly_pakistan_fyp/providers/user/user_provider.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/widgets/radio_button_list.dart';
import 'package:truly_pakistan_fyp/utils.dart';

class CheckoutActivity extends StatefulWidget {

  final MarketPlaceItemModel product;

  const CheckoutActivity(this.product,{Key key}) : super(key: key);

  @override
  _CheckoutActivityState createState() => _CheckoutActivityState();
}

class _CheckoutActivityState extends State<CheckoutActivity> {
  int quantity=1;
  UserModel user;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _phoneNumberController;
  TextEditingController _countryController;
  TextEditingController _provinceController;
  TextEditingController _cityController;
  TextEditingController _addressController;
  TextEditingController _houseNoController;
  TextEditingController _sideNotesController;

  @override
  void initState() {
    user=Provider.of<UserProvider>(context,listen: false).getCurrentUser();
    _nameController=TextEditingController();
    _nameController.text=user.name;
    _emailController=TextEditingController();
    _emailController.text=user.email;
    _phoneNumberController=TextEditingController();
    _phoneNumberController.text=user.phoneNumber;
    _countryController=TextEditingController();
    _countryController.text=user.country;
    _provinceController=TextEditingController();
    _provinceController.text=user.state;
    _cityController=TextEditingController();
    _cityController.text=user.city;
    _addressController=TextEditingController();
    _houseNoController=TextEditingController();
    _sideNotesController=TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: screenWidth/2,
              width: screenWidth,
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag:widget.product.images[0],
                    child: CachedNetworkImage(
                      imageUrl: widget.product.images[0],
                      width: screenWidth,
                      height: screenWidth/2,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: screenWidth,
                      color: Color(0x22000000),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.product.title??"",
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
              height: screenHeight-(screenWidth/2),
              color: Color(0xFFEEEEEE),
              child: CustomScrollView(
                scrollDirection: Axis.vertical,
//                padding: EdgeInsets.all(0),
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0)
                        ),
                        margin: EdgeInsets.only(left: 16,right: 16,top: 16),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Cost"),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          setState(() {
                                            if(quantity!=1)
                                              quantity-=1;
                                          });
                                        },
                                        icon: Icon(Icons.remove),
                                      ),
                                      Text(quantity.toString()),
                                      IconButton(
                                        onPressed: (){
                                          print("onPressed$quantity");
                                          setState(() {
                                            quantity+=1;
                                          });
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  Text((widget.product.price*quantity).toString(),style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _phoneNumberController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _countryController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Country',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _provinceController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Province',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _cityController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'City',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Address',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _houseNoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'House Number',
                          ),
                        ),
                      ),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _sideNotesController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                            labelText: 'Side Notes',
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 24,horizontal: 16),
                        child: MaterialButton(
                          color: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          height: 50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          onPressed: onOrderPlaced,
                          child: Text("Place Order",style: TextStyle(color: Theme.of(context).canvasColor),),
                        ),
                      )
                    ]),
                  ),
                ],
              ),
            )
          ],
        )
    );

  }

  void onOrderPlaced() async{
    OrderModel order=OrderModel();
    OrderDetailsModel orderDetails=OrderDetailsModel();
    orderDetails.totalPrice=widget.product.price*quantity;
    orderDetails.quantity=quantity.toString();
    orderDetails.price=widget.product.price;
    orderDetails.productDetails=widget.product;
    orderDetails.user=user;
    order.orderDetails=orderDetails;
    ShippingDetailsModel shippingDetails=ShippingDetailsModel();
    shippingDetails.name=_nameController.text;
    shippingDetails.email=_emailController.text;
    shippingDetails.phoneNumber=_phoneNumberController.text;
    shippingDetails.country=_countryController.text;
    shippingDetails.state=_provinceController.text;
    shippingDetails.city=_cityController.text;
    shippingDetails.address=_addressController.text;
    shippingDetails.houseNumber=_houseNoController.text;
    shippingDetails.quantity=quantity.toString();
    shippingDetails.sideNotes=_sideNotesController.text;
    order.shippingDetails=shippingDetails;
    DocumentReference ref=FirebaseFirestore.instance.collection("users").doc(widget.product.user.uid).collection("Orders").doc();
    await ref.set(order.toMap());
    await FirebaseFirestore.instance.collection("users").doc(user.uid).collection("Orders").doc(ref.id).set(order.toMap());
    longToast("Order placed", context);
    Navigator.of(context).pop();
  }
}
