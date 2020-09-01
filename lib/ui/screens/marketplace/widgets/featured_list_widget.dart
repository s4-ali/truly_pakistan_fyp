import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/models/ad_model.dart';
//import 'package:truly_pakistan/ui.marketplace/data.dart';

class FeatureListWidget extends StatefulWidget {

  final List<AdModel> adModels;
  final String title;


  FeatureListWidget({this.title,this.adModels,});

  @override
  _FeatureListWidgetState createState() => _FeatureListWidgetState(adModels.length-1);

}

class _FeatureListWidgetState extends State<FeatureListWidget> {
  var currentPage;
  _FeatureListWidgetState(this.currentPage);

  @override
  Widget build(BuildContext context) {


    PageController controller = PageController(initialPage: widget.adModels.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Column(
      children: <Widget>[

        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.0,top: 8),
            child: Text("Featured",
                style: TextStyle(
                  color: Color(0xff008736),
                  fontSize: 38.0,
                  fontFamily: "Calibre-Semibold",
                  letterSpacing: 1.0,
                )),
          ),
        ),
        //Scroll
        Stack(
          children: <Widget>[
            CardScrollWidget(currentPage,widget.adModels),
            Positioned.fill(
              child: PageView.builder(
                itemCount: widget.adModels.length,
                controller: controller,
                reverse: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: (){
                      print("pressed");
                    },
                    child: Container(),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;


class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20.0;
  var verticalInset = 20.0;
  List<AdModel> adModels;

  CardScrollWidget(this.currentPage,this.adModels);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: widgetAspectRatio,
      child: LayoutBuilder(builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget> cardList = new List();

        for (var i = 0; i < adModels.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 15 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 5,offset: Offset(6,6)),],
                border: Border.all(color: Color(0x0f000000),width: 1)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: AspectRatio(
                  aspectRatio: cardAspectRatio,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      GestureDetector(
                        onTap:(){
                          print("Pressed:$i");
                        },
                        child: Image.network(adModels[i].imgUrl, fit: BoxFit.cover),
                      ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Wrap(
//                            direction: ,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Color(0x2F000000), offset: Offset(6,6),blurRadius: 6)],
                                  color: Color(0xfffbfbfb),
                                ),
                                alignment: Alignment.bottomCenter,
                                width: safeWidth,
                                padding: EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      adModels[i].title,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Align(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.history, size: 17,color: Color(0xffB1B1B1),),
                                                  Text("  7 Days, ISB",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xff888888),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.history, size: 17,color: Color(0xffB1B1B1),),
                                                  Text("  13-JAN-2020",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color(0xff888888),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.bottomLeft,
                                        ),

                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(adModels[i].price,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff008B6A)
                                            ),),
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}


