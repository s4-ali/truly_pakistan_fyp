import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

double getTopPadding(BuildContext context){
  return MediaQuery.of(context).padding.top;
}

void shortToast(String msg,BuildContext context){
  Toast.show(msg, context, duration: Toast.LENGTH_SHORT,gravity: Toast.BOTTOM);
}

void longToast(String msg,BuildContext context){
  Toast.show(msg, context, duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
}


void showCustomDialog(BuildContext context, String title,List<String> options, void Function(int index) onItemSelected) {
  Dialog errorDialog = Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 24,horizontal: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((e) => Container(
          width: double.infinity,
          child: MaterialButton(
            onPressed: (){
              onItemSelected(options.indexOf(e));
              Navigator.of(context,rootNavigator: true).pop();
            },
            child: Center(child: Text(e)),
          ),
        ),
        ).toList()
          ..add(
            Container(
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                color: Colors.red,
                onPressed: (){
                  Navigator.of(context,rootNavigator: true).pop();
                },
                child: Center(child: Text("Cancel",style: TextStyle(color: Colors.white),),),
              ),
            ),
          )..insert(0, Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),
              ),
            ),
          )),
      ),
    ),
  );
  showDialog(context: context, builder: (BuildContext context) => errorDialog);
}

Color getTextColor(BuildContext context){
  return Theme.of(context).textTheme.bodyText1.color;
}

final List<int> _times = [
  Duration(days: 365).inMilliseconds,
  Duration(days: 30).inMilliseconds,
  Duration(days: 1).inMilliseconds,
  Duration(hours: 1).inMilliseconds,
  Duration(minutes: 1).inMilliseconds,
  Duration(seconds: 1).inMilliseconds,
];
final List<String> _timesString = [
  "year",
  "month",
  "day",
  "hour",
  "minute",
  "second"
];

String toDuration(int duration) {
  String res = "";
  for (int i = 0; i < _times.length; i++) {
    int current = _times[i];
    int temp = duration ~/ current;
    if (temp > 0) {
      res += temp.toString();
      res += " ";
      res += _timesString[i];
      res += (temp != 1 ? "s" : "");
      res += " ago";
      break;
    }
  }
  if ("" == res.toString())
    return "0 seconds ago";
  else
    return res.toString();
}