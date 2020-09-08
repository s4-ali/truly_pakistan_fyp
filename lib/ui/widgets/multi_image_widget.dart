import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MultiImageWidget extends StatefulWidget {


  final List<String> images;

  const MultiImageWidget({Key key, this.images}) : super(key: key);

  @override
  _MultiImageWidgetState createState() => _MultiImageWidgetState();
}

class _MultiImageWidgetState extends State<MultiImageWidget> {
  var currentPage;

  @override
  void initState() {
    currentPage=(widget.images.length-1).toDouble();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    PageController controller = PageController(initialPage: widget.images.length-1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Stack(
      children: <Widget>[
        _SingleImageWidget(currentPage,widget.images),
        Positioned.fill(
          child: PageView.builder(
            itemCount: widget.images.length,
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
    );
  }
}


class _SingleImageWidget extends StatelessWidget {
  final currentPage;
  final List<String> images;

  const _SingleImageWidget(this.currentPage, this.images,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 16.0 / 12.0;
    var widgetAspectRatio = cardAspectRatio * 1.13;
    var padding = 8.0;
    var verticalInset = 20.0;
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

        for (var i = 0; i < images.length; i++) {
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
                  borderRadius: BorderRadius.circular(10.0),
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
                        child: CachedNetworkImage(imageUrl:images[i], fit: BoxFit.cover),
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

