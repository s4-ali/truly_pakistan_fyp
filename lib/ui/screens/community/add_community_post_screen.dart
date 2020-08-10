import 'package:flutter/material.dart';

class AddCommunityPostScreen extends StatefulWidget {
  @override
  _AddCommunityPostScreenState createState() => _AddCommunityPostScreenState();
}

class _AddCommunityPostScreenState extends State<AddCommunityPostScreen> {
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.backgroundColor,
        centerTitle: true,
        title: Text("Ask Question",style: TextStyle(color: theme.primaryColor),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: theme.primaryColor,),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text("Ask",style: TextStyle(color: theme.primaryColor,fontSize: 15),)),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 16,right: 16),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title"
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "How may community help you?"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 8),
            child: Text("Tags",style: Theme.of(context).textTheme.headline6,),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 3,offset: Offset(0,2),blurRadius: 2)],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("#Hiking",),
                      SizedBox(width: 8,),
                      Icon(Icons.clear,),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
