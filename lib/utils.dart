import 'package:flutter/cupertino.dart';
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