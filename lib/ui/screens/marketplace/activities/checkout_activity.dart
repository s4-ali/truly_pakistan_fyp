import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/widgets/radio_button_list.dart';

class CheckoutActivity extends StatelessWidget {


  final String position;
  final String path;

  const CheckoutActivity({Key key, this.position, this.path}) : super(key: key);

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
                    tag:"cover_image$position",
                    child: Image.network(path,
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
                        child: Text("Tour to Swat, Malam Jabba and Kalam Valley",
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
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Tour Charges"),
                                  Text("14,000 Rs",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ),
                            Container(color: Colors.black26,height: 1,margin: EdgeInsets.symmetric(horizontal: 32),),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Departure Date"),
                                  Text("14-FEB-2019",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w600),),
                                ],
                              ),
                            ),
//                        Container(color: Colors.black45,height: 1,margin: EdgeInsets.symmetric(horizontal: 32),),

                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16,left: 24),
                        child: Text("Pick Up Location",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                    ]),
                  ),
                  RadioButtonList(radioButtonData:[
                    RadioButtonData("Islamabad",Icons.location_on,"+0Rs"),
                    RadioButtonData("Faisalabad",Icons.location_on,"+1000Rs"),
                    RadioButtonData("Lahore",Icons.location_on,"+1500Rs"),
                  ]),
                ],
              ),
            )
          ],
        )
    );

  }
}
