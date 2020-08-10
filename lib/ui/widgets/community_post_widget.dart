import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/static_data.dart';

class CommunityPostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(1,3),blurRadius: 3,spreadRadius: 0)],
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: "https://picsum.photos/seed/picsum/200/200",
                  fit: BoxFit.cover,
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(width: 8,),
              Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Text(
                    "Whats best place for breakfast in lahore?",
                    style: TextStyle(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                  Text("#Tag1  #Tag1",style: Theme.of(context).textTheme.caption,)
                ],
              ),
            ],
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("12 votes | 2 answers"),
              Text("5 minutes ago")
            ],
          ),
        ],
      ),
    );
  }
}
