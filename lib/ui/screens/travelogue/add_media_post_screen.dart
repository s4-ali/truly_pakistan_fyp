import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AddMediaPostScreen extends StatefulWidget {
  @override
  _AddMediaPostScreenState createState() => _AddMediaPostScreenState();
}

class _AddMediaPostScreenState extends State<AddMediaPostScreen> {
  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.backgroundColor,
        centerTitle: true,
        title: Text("Create Travelogue",style: TextStyle(color: theme.primaryColor),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: theme.primaryColor,),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(child: Text("Post",style: TextStyle(color: theme.primaryColor,fontSize: 15),)),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getAddMediaSection(),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Tell the world about your adventures"
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,bottom: 8),
            child: Text("Places",style: Theme.of(context).textTheme.headline6,),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 0,offset: Offset(0,2),blurRadius: 2)],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Islamabad",),
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
          SizedBox(height: 16,),
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
                    boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 0,offset: Offset(0,2),blurRadius: 2)]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Hiking"),
                      SizedBox(width: 8,),
                      Icon(Icons.clear),
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

  Widget _getAddMediaSection() {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 16,top: 16),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black12,spreadRadius: 0,offset: Offset(0,2),blurRadius: 2)]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: "https://picsum.photos/seed/picsum/200/200",
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16,top: 16),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(16)
          ),
          child: Center(
            child: Icon(Icons.add,color: Theme.of(context).textTheme.bodyText1.color,size: 50,),
          ),
        ),
      ],
    );
  }
}
