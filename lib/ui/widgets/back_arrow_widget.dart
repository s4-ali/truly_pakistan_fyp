import 'package:flutter/material.dart';

class BackArrowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
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
    );
  }
}
