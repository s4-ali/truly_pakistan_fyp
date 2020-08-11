import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RadioButtonList extends StatefulWidget {
  final List<RadioButtonData> radioButtonData;

  RadioButtonList({this.radioButtonData});

  @override
  _RadioButtonListState createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {

  int selectedRadio=0;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate:SliverChildBuilderDelegate((context,position){
        double margin=position==0?16:8;
          return Container(
              margin: EdgeInsets.only(top: margin,right: 16,left: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
            child:Row(
              children: <Widget>[
                Icon(widget.radioButtonData[position].iconData,size: 24,color: Colors.black,),
                Text(widget.radioButtonData[position].title),
                Flexible(child: Container(),),
                Text(widget.radioButtonData[position].endText),
              ],
            )
          );
        },
        childCount: widget.radioButtonData.length
      )
    );
  }
}

class RadioButtonData{

  RadioButtonData(this.title,this.iconData,this.endText);

  String title;
  IconData iconData;
  String endText;
}