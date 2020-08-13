import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/static_data.dart';
import 'package:truly_pakistan_fyp/ui/screens/marketplace/data.dart';

class ViewCommunityPostScreen extends StatefulWidget {
  @override
  _ViewCommunityPostScreenState createState() => _ViewCommunityPostScreenState();
}

class _ViewCommunityPostScreenState extends State<ViewCommunityPostScreen> {

  Widget _getUserSection() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network("https://picsum.photos/seed/picsum/200/200", height: 50.0, width: 50.0,),
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Meesum Raza",style: Theme.of(context).textTheme.headline6,),
                    Text("1 hour ago",style: TextStyle(color: Theme.of(context).textTheme.bodyText1.color.withAlpha(180),fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),
          Text("23 votes",style: Theme.of(context).textTheme.headline6.copyWith(color: Theme.of(context).primaryColor),),
        ],
      ),
    );
  }


  Widget _getSingleMediaView() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(35),blurRadius: 6,offset: Offset(0,3),spreadRadius: 4)],
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: adModels[6].imgUrl,
            width: double.infinity,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error,color: Colors.red,),
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.backgroundColor,
        centerTitle: true,
        title: Text("Question",style: TextStyle(color: theme.primaryColor),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,color: theme.primaryColor,),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.more_vert,color: theme.primaryColor,),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(0,3),blurRadius: 3),],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _getUserSection(),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 16),
                  child: Text("Loren ipsum title",style: theme.textTheme.headline6,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8,left: 16,right: 16),
                  child: Text(loremIpsum),
                ),
                _getSingleMediaView(),
                Padding(
                  padding: EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 8),
                  child: Text("#Tag1 Tag2",style: theme.textTheme.subtitle1,),
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_upward),
                      iconSize: 30,
                      color: theme.primaryColor,
                    ),
                    Text("23",style: TextStyle(fontSize: 16,color: theme.primaryColor),),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 30,
                      color: theme.primaryColor,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16,right: 16,top: 16),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Got an answer?"
              ),
            ),
          ),
          SizedBox(height: 16,),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_upward),
                    iconSize: 30,
                    color: theme.primaryColor,
                  ),
                  Text("10",style: TextStyle(fontSize: 16,color: theme.primaryColor),),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 30,
                    color: theme.primaryColor,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 3,offset: Offset(0,3))]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Saad Ansar",style: theme.textTheme.headline6.copyWith(color: theme.primaryColor),),
                      Text(loremIpsum)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16,),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_upward),
                    iconSize: 30,
                    color: theme.primaryColor,
                  ),
                  Text("10",style: TextStyle(fontSize: 16,color: theme.primaryColor),),
                  IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 30,
                    color: theme.primaryColor,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 3,offset: Offset(0,3))]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Iqra Javed",style: theme.textTheme.headline6.copyWith(color: theme.primaryColor),),
                      Text(loremIpsum)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}
