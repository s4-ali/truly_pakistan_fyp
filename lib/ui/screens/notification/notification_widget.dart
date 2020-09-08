import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:truly_pakistan_fyp/models/notifications/notifications_model.dart';

class NotificationWidget extends StatelessWidget {
  final NotificationModel notification;

  const NotificationWidget(this.notification,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12,offset: Offset(0,3),blurRadius: 3)]
      ),
      child: Row(
        children: [
          if(notification.icon!=null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: notification.icon,
                height: 50,
                width: 50,
                fit: BoxFit.fill,
              ),
            ),
          SizedBox(width: 8,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification.title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                Text(notification.body,softWrap: false,overflow: TextOverflow.ellipsis,maxLines: 2,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
